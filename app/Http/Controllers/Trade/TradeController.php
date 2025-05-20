<?php

namespace App\Http\Controllers\Trade;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

use App\Models\Offer;
use App\Models\Deal;
use App\Models\Category;
use App\Models\Currency;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;
class TradeController extends Controller
{
    public function index(Request $request)
    {
        $query = Offer::with(['user'])
        ->where('is_active', 1);
        if ($request->filled('category_id')) {
            $query->where('category_id', $request->category_id);
        }
    
        // фильтр по названию
        if ($request->filled('search')) {
            $query->where('title', 'like', '%' . $request->search . '%');
        }
        $offers = $query->latest()
            ->take(100)
            ->get()
            ->map(function ($offer) {
                return [
                    'id' => $offer->id,
                    'title' => $offer->title,
                    'description' => $offer->description,
                    'price_per_unit' => number_format($offer->price, 2, '.', ' '),
                    'quantity' => $offer->quantity,
                    'currency' => [
                        'id' => $offer->id,
                        'name' => $offer->name,
                    ],
                    'user' => [
                        'id' => $offer->user->id,
                        'name' => $offer->user->name,
                    ],
                ];
            });

      
       
        return Inertia::render('Trades/Index', [
            'offers' => $offers,
            'categories' => Category::select('id', 'name')->get(),
            'filters' => $request->only('category_id', 'search')
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'price_per_unit' => 'required|numeric|min:0.01',
            'quantity' => 'required|integer|min:1',
            'currency_id' => 'required|exists:currencies,id',
        ]);

        Offer::create([
            'user_id' => Auth::id(),
            'currency_id' => $validated['currency_id'],
            'title' => $validated['title'],
            'description' => $validated['description'],
            'price_per_unit' => $validated['price_per_unit'],
            'quantity' => $validated['quantity'],
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
