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
            'title' => 'required',
            'description' => 'nullable',
            'full_description' => 'nullable',
            'category_id' => 'required|exists:categories,id',
            'game_id' => 'nullable|exists:games,id',
            'server_id' => 'nullable|exists:servers,id',
            'price' => 'required|numeric|min:0.01',
            'quantity' => 'required|integer|min:1',
        ]);
        $buyerPercent = config('fees.buyer_percent');
        $rawPrice   = (float) $data['price'];
        $finalPrice = round($rawPrice * (1 + $buyerPercent / 100), 2);
        Offer::create([
            'user_id' => auth()->id(),
            'category_id' => $request->category_id,
            'game_id' => $request->game_id,
            'server_id' => $request->server_id,
            'title' => $request->title,
            'description' => $request->description,
            'price' =>  $finalPrice,
            'quantity' => $request->quantity,
            'is_active' => true,
            'fee_model' => config('fees.model'),       // по умолчанию покупатель платит
            'fee_buyer_percent' => config('fees.buyer_percent'),       // процент комиссии для покупателя
            'fee_seller_percent' => config('fees.seller_percent'),        // продавец не платит
        ]);

        return redirect()->route('offers.index')->with('success', 'Оффер создан.');
    }

    public function buy(Request $request)
    {
    $data = $request->validate([
        'offer_id' => 'required|exists:offers,id',
        'quantity' => 'required|integer|min:1',
        'payment_method_id' => 'required|exists:payment_methods,id',
    ]);

    $user = Auth::user();
    $offer = Offer::findOrFail($data['offer_id']);

    if ($data['quantity'] > $offer->quantity) {
        return back()->withErrors(['quantity' => 'Недостаточное количество в наличии.']);
    }

    $totalPrice = $offer->price * $data['quantity'];

    if ($user->balance < $totalPrice) {
        return back()->withErrors(['quantity' => 'Недостаточно средств для покупки! Пополните счет.']);
    }

    $user->balance -= $totalPrice;
    $user->save();

    $deal = Deal::create([
        'buyer_id' => $user->id,
        'offer_id' => $offer->id,
        'quantity' => $data['quantity'],
        'payment_method_id' => $data['payment_method_id'],
        'total_price' => $totalPrice,
        'status' => 'pending',
    ]);

    $offer->quantity -= $data['quantity'];
    if ($offer->quantity <= 0) {
        $offer->is_active = false;
    }
    $offer->save();

    return Inertia::location(route('deals.show', $deal->id));
    }
        public function show(Deal $deal)
{
    $this->authorize('view', $deal); // Покупатель или продавец
    return Inertia::render('Deals/Show', [
        'deal' => $deal->load('offer.user'),
    ]);
}

public function confirm(Request $request, Deal $deal)
{
    $this->authorize('update', $deal);
    
    if ($deal->status !== 'paid') {
        return back()->withErrors(['status' => 'Сделка должна быть оплачена.']);
    }

    $deal->update([
        'status' => 'completed',
    ]);

    $seller = $deal->offer->user;
    $seller->balance += $deal->total_price;
    $seller->save();

    return redirect()->route('dashboard')->with('success', 'Сделка подтверждена, средства переведены продавцу.');
}
}