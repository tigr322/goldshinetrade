<?php

namespace App\Http\Controllers\Trade;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use App\Models\Offer;
use App\Models\Deal;
use App\Models\Category;
use App\Models\Game;
use App\Models\Server;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;
class TradeController extends Controller
{
    public function index(Request $request)
{
    $query = Offer::with(['user', 'server.game.categories'])
        ->where('is_active', 1);

    if ($request->filled('category_id')) {
        $query->where('category_id', $request->category_id);
    }

    // фильтр по категории игры
    if ($request->filled('game_category_id')) {
        $query->whereHas('server.game.categories', function ($q) use ($request) {
            $q->where('game_categories.id', $request->game_category_id);
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
            'price_per_unit' => number_format($offer->price, 2, '.', ' '),
            'quantity' => $offer->quantity,
            'currency' => [
                'id' => $offer->id,
                'name' => $offer->name, // предполагается, что это не offer->name, а offer->currency->name
            ],
            'user' => [
                'id' => $offer->user->id,
                'name' => $offer->user->name,
            ],
            'category_id' => $offer->category_id,
            'game_category_ids' => $offer->gameCategoryIds(),
        ];
    });
    $gameCategories = Category::whereHas('games')  // Только те категории, у которых есть игры
    ->select('id', 'name')
    ->get();
    return Inertia::render('Trades/Index', [
        'offers' => $offers,
        'categories' => Category::select('id', 'name')->get(),
        'gameCategories' => $gameCategories ,
        'filters' => $request->only('category_id', 'search', 'game_category_id'),
        'games' => Game::select('id', 'name')->get(),
        'servers' => Server::select('id', 'name')->get(),
    ]);
}



    public function store(Request $request)
    {
        $request->validate([
            'title' => 'required',
            'description' => 'nullable',
            'category_id' => 'required|exists:categories,id',
            'game_category_id' => 'nullable|exists:game_category,id',
            'game_id' => 'nullable|exists:games,id',
            'server_id' => 'nullable|exists:servers,id',
            'price' => 'required|numeric|min:0.01',
            'quantity' => 'required|integer|min:1',
            
        ]);
        
        Offer::create([
            'user_id' => Auth::id(),
            'category_id' => $request->category_id,
            'server_id' => $request->server_id,
            'game_category_id' => $request->game_category_id,
            'game_id' => $request->game_id,
            'title' => $request->title,
            'description' => $request->description,
            'price' => $request->price,
            'quantity' => $request->quantity,
            'is_active' => true,
        ]);
        

        return redirect()->route('offers.index')->with('success', 'Оффер создан.');
    }

    public function buy(Request $request)
    {
        $data = $request->validate([
            'offer_id' => 'required|exists:offers,id',
            'quantity' => 'required|integer|min:1',
        ]);

        $offer = Offer::findOrFail($data['offer_id']);

        if ($data['quantity'] > $offer->quantity) {
            return back()->withErrors(['quantity' => 'Недостаточное количество в наличии.']);
        }

        $totalPrice = $offer->price_per_unit * $data['quantity'];

        Deal::create([
            'buyer_id' => Auth::id(),
            'offer_id' => $offer->id,
            'quantity' => $data['quantity'],
            'total_price' => $totalPrice,
            'status' => 'pending',
        ]);

        $offer->quantity -= $data['quantity'];
        if ($offer->quantity <= 0) {
            $offer->is_active = false;
        }
        $offer->save();

        return redirect()->route('offers.index')->with('success', 'Сделка создана.');
    }
}
