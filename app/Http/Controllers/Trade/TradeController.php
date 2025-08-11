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
    public function pay(Request $request, Deal $deal)
    {
        $data = $request->validate([
            'quantity' => ['required','integer','min:1'],
        ]);
    
        $user = auth()->user();
        abort_if($deal->buyer_id !== $user->id, 403);
        abort_if($deal->status !== 'pending', 422, 'Сделка уже оплачена или завершена');
    
        $offer = $deal->offer()->lockForUpdate()->first();
        $qty   = min($data['quantity'], $offer->quantity); // не больше остатка
        if ($qty < 1) {
            return response()->json(['message' => 'Недостаточно товара в наличии'], 422);
        }
    
        $unitPrice = (float) $offer->price; // уже с процентом
        $total = round($unitPrice * $qty, 2);
    
        if ($user->balance < $total) {
            return response()->json(['message' => 'Недостаточно средств на балансе'], 422);
        }
    
        DB::transaction(function () use ($user, $deal, $offer, $qty, $total) {
            $user->decrement('balance', $total);
    
            $deal->update([
                'quantity'      => $qty,
                'total_price'   => $total,
                'status'        => 'paid',
                'escrow_amount' => $total,
            ]);
    
            $offer->decrement('quantity', $qty);
            if ($offer->quantity <= 0) {
                $offer->update(['is_active' => false]);
            }
        });
    
        return response()->json(['ok' => true]);
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

public function confirm(Deal $deal)
{
    $user = Auth::user();
    abort_unless($deal->buyer_id === $user->id, 403);
    abort_unless($deal->status === 'paid' && $deal->escrow_amount > 0, 422);

    DB::transaction(function () use ($deal) {
        $offer  = $deal->offer()->lockForUpdate()->first();
        $seller = $offer->user()->lockForUpdate()->first();

        // сколько выплатить продавцу: базовая цена * qty
        // если base_price отсутствует (старые офферы) — вычислим из текущего price и процента
        $buyerPercent = (float) config('fees.buyer_percent');
        $baseUnit = $offer->base_price
            ?? round($offer->price / (1 + $buyerPercent/100), 2);

        $payout = round($baseUnit * $deal->quantity, 2);

        // переводим продавцу
        $seller->increment('balance', $payout);

        // обновляем сделку
        $deal->update([
            'confirmed_at' => now(),
            'released_at'  => now(),
            'status'       => 'released',
            'escrow_amount'=> 0,
        ]);
    });

    return back()->with('status', 'Получение подтверждено, средства выплачены продавцу.');
}

}