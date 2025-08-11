<?php

namespace App\Http\Controllers\Trade;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Offer;
use App\Models\Deal;
use App\Models\Category;
use App\Models\Game;
use App\Models\Server;
use App\Models\GameType;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;
use App\Models\PaymentMethod;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Support\Facades\DB; 


class TradeController extends Controller
{
    use AuthorizesRequests;
    public function index(Request $request)
    {
        $query = Offer::with(['user', 'game', 'server'])
            ->where('is_active', 1);

        if ($request->filled('category_id')) {
            $query->where('category_id', $request->category_id);
        }

        if ($request->filled('game_category_id')) {
            $query->whereHas('game', function ($q) use ($request) {
                $q->where('game_type_id', $request->game_category_id);
            });
        }

        if ($request->filled('search')) {
            $query->where('title', 'like', '%' . $request->search . '%');
        }

        $offers = $query->latest()->take(100)->get()->map(function ($offer) {
            return [
                'id' => $offer->id,
                'title' => $offer->title,
                'description' => $offer->description,
                'full_description'=> $offer->full_description,
                'price_per_unit' => number_format($offer->price, 2, '.', ' '),
                'quantity' => $offer->quantity,
                'currency' => [
                    'id' => $offer->id,
                    'name' => '₽', // предполагаем, что пока это фиксированная валюта
                ],
                'user' => [
                    'id' => $offer->user->id,
                    'name' => $offer->user->name,
                    'photo' => $offer->user->photo,
                ],
                'category_id' => $offer->category_id,
                'game_name' => optional($offer->game)->name,
                'server_name' => optional($offer->server)->name,
                'game_type_id' => optional($offer->game)->game_type_id,
                // добавлено
            ];
        });

        return Inertia::render('Trades/Index', [
            'offers' => $offers,
           'categories' => Category::withCount('games')->get(),
            'gameCategories' => GameType::select('id', 'name')->get(),
            'filters' => $request->only('category_id', 'search', 'game_category_id'),
            'games' => Game::select('id', 'name', 'category_id', 'game_type_id')->get(),
           'servers' => Server::select('id', 'name', 'game_id')->get(),
           'paymentMethods' => PaymentMethod::select('id', 'name')->get(), 
           'fees' => config('fees'),
        ]);
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'title'=>'required','description'=>'nullable','full_description'=>'nullable',
            'category_id'=>'required|exists:categories,id',
            'game_id'=>'nullable|exists:games,id',
            'server_id'=>'nullable|exists:servers,id',
            'price'=>'required|numeric|min:0.01',
            'quantity'=>'required|integer|min:1',
        ]);
        
        $buyerPercent = (float) config('fees.buyer_percent'); // из конфига
        $basePrice    = (float) $data['price'];               // цена продавца
        $finalPrice   = round($basePrice * (1 + $buyerPercent/100), 2); // что видит покупатель
        
        Offer::create([
            'user_id' => auth()->id(),
            'category_id' => $data['category_id'],
            'game_id' => $data['game_id'],
            'server_id' => $data['server_id'],
            'title' => $data['title'],
            'description' => $data['description'],
            'full_description' => $data['full_description'],
            'base_price' => $basePrice, // сохраняем базовую
            'price' => $finalPrice,     // итог для покупателя
            'quantity' => $data['quantity'],
            'is_active' => true,
        ]);
        

        return redirect()->route('offers.index')->with('success', 'Оффер создан.');
    }
    public function pay(Request $request, \App\Models\Deal $deal)
    {
        $data = $request->validate(['quantity' => ['required','integer','min:1']]);
    
        $user = auth()->user();
        if ($deal->buyer_id !== $user->id) {
            return response()->json(['message' => 'Оплатить может только покупатель.'], 422);
        }
        if ($deal->status !== 'pending') {
            return response()->json(['message' => 'Сделка уже оплачена или завершена.'], 422);
        }
    
        try {
            DB::transaction(function () use ($deal, $user, $data) {
                // ВАЖНО: lockForUpdate ТОЛЬКО внутри транзакции
                $offer = $deal->offer()->lockForUpdate()->firstOrFail();
    
                $qty = min((int)$data['quantity'], (int)$offer->quantity);
                if ($qty < 1) {
                    abort(422, 'Недостаточно товара в наличии.');
                }
    
                $unitPrice = (float) $offer->price; // цена для покупателя (уже с +%)
                $total     = round($unitPrice * $qty, 2);
    
                // Можно тоже залочить пользователя, если очень щепетильно (опционально):
                // $user->refresh();
                if ($user->balance < $total) {
                    abort(422, 'Недостаточно средств на балансе.');
                }
    
                // списываем у покупателя и замораживаем
                $user->decrement('balance', $total);
    
                $deal->update([
                    'quantity'      => $qty,
                    'total_price'   => $total,
                    'status'        => 'paid',
                    'escrow_amount' => $total,
                ]);
    
                // уменьшаем остаток оффера
                $offer->decrement('quantity', $qty);
                if ($offer->quantity - $qty <= 0) {
                    $offer->is_active = false;
                    $offer->save();
                }
            });
    
            return response()->json(['ok' => true]);
        } catch (\Throwable $e) {
            // в лог можно кинуть $e->getMessage()
            return response()->json(['message' => 'Серверная ошибка при оплате'], 500);
        }
    }
    
public function buy(Request $request)
{
    $data = $request->validate([
        'offer_id' => ['required','exists:offers,id'],
    ]);

    $user  = Auth::user();
    $offer = \App\Models\Offer::findOrFail($data['offer_id']);

    // нельзя купить свой оффер
    if ($offer->user_id === $user->id) {
        return $request->wantsJson()
            ? response()->json(['message' => 'Нельзя купить свой оффер'], 422)
            : back()->withErrors(['offer' => 'Нельзя купить свой оффер']);
    }

    // оффер должен быть активен и иметь остаток
    if (!$offer->is_active || (int) $offer->quantity <= 0) {
        return $request->wantsJson()
            ? response()->json(['message' => 'Оффер недоступен'], 422)
            : back()->withErrors(['offer' => 'Оффер недоступен']);
    }

    // создаём заготовку сделки (дальше количество/оплата на странице сделки)
    $deal = Deal::create([
        'buyer_id'    => $user->id,
        'offer_id'    => $offer->id,
        'quantity'    => 1,
        'total_price' => $offer->price,
        'status'      => 'pending',
        'payment_method_id' => null, // <- важно
    ]);

    // XHR → JSON с redirect; обычный запрос → обычный redirect
    if ($request->wantsJson()) {
        return response()->json([
            'deal_id'  => $deal->id,
            'redirect' => route('deals.show', $deal->id),
        ]);
    }

    return redirect()->route('deals.show', $deal->id);
}
        public function show(Deal $deal)
{
    $this->authorize('view', $deal); // Покупатель или продавец
    return Inertia::render('Deals/Show', [
        'deal' => $deal->load('offer.user'),
    ]);
}

public function confirm(\App\Models\Deal $deal)
{
    $user = auth()->user();

    if ($deal->buyer_id !== $user->id) {
        return response()->json(['message' => 'Подтверждать может только покупатель.'], 422);
    }
    if ($deal->status !== 'paid') {
        return response()->json(['message' => 'Сделка ещё не оплачена.'], 422);
    }
    if ((float)$deal->escrow_amount <= 0) {
        return response()->json(['message' => 'Нет замороженных средств для выплаты.'], 422);
    }

    try {
        DB::transaction(function () use ($deal) {
            $offer  = $deal->offer()->lockForUpdate()->firstOrFail();
            $seller = $offer->user()->lockForUpdate()->firstOrFail();

            // Простой вариант: выплачиваем ВСЮ сумму из эскроу
            $payout = (float) $deal->escrow_amount;

            $seller->increment('balance', $payout);

            $deal->update([
                'confirmed_at'  => now(),
                'released_at'   => now(),
                'status'        => 'completed',
                'escrow_amount' => 0,
            ]);
        });

        return response()->json(['ok' => true]);
    } catch (\Throwable $e) {
        return response()->json(['message' => 'Внутренняя ошибка при подтверждении'], 500);
    }
}
}