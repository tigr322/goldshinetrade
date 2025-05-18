<?php
	use App\Models\Currency;
    use Illuminate\Support\Facades\Route;
    Route::get('/currencies', function () {
        return Currency::all();
    });