<?php

namespace App\Http\Controllers\Admin;



use App\Http\Controllers\Controller;
use App\Models\Offer;
use Illuminate\Http\Request;
use Inertia\Inertia;

class AdminOfferController extends Controller
{
    public function index()
    {
        $offers = Offer::latest()->paginate(15);
        return Inertia::render('Admin/Offers/Index', [
            'offers' => $offers,
        ]);
    }

    public function edit(Offer $offer)
    {
        return Inertia::render('Admin/Offers/Edit', [
            'offer' => $offer,
        ]);
    }

    public function update(Request $request, Offer $offer)
    {
        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'price' => 'required|numeric',
        ]);

        $offer->update($validated);

        return redirect()->route('admin.offers.index')->with('success', 'Оффер обновлён.');
    }

    public function destroy(Offer $offer)
    {
        $offer->delete();

        return back()->with('success', 'Оффер удалён.');
    }
}