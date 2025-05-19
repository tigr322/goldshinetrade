<?php

use App\Http\Controllers\MainController;
use App\Http\Controllers\ProfileController;
use Illuminate\Foundation\Application;
use App\Http\Controllers\Trade\TradeController;

use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

Route::get('/', function () {
    return Inertia::render('Welcome', [
        'canLogin' => Route::has('login'),
        'canRegister' => Route::has('register'),
        'laravelVersion' => Application::VERSION,
        'phpVersion' => PHP_VERSION,
    ]);
});
Route::middleware(['auth'])->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('admin.dashboard');
    Route::get('/offers', [TradeController::class, 'index'])->name('offers.index');
   Route::post('/offers', [TradeController::class, 'store'])->name('offers.store');
    Route::post('/deals', [TradeController::class, 'buy'])->name('deals.buy'); 
Route::get('/dashboard', [MainController::class, 'index'])->name('dashboard');
Route::get('/exchange', function () {
    return Inertia::render('Exchange');
})->name('exchange');

// Мои картывыв
Route::get('/cards', function () {
    return Inertia::render('Cards');
})->name('cards');

// Мои счетаfdfd
Route::get('/accounts', function () {
    return Inertia::render('Accounts');
})->name('accounts');

// Жалобы
Route::get('/complaints', function () {
    return Inertia::render('Complaints');
})->name('complaints');

// Настройки
Route::get('/settings', function () {
    return Inertia::render('Settings');
})->name('settings');

// Помощь
Route::get('/help', function () {
    return Inertia::render('Help');
})->name('help');

// Безопасность
Route::get('/security', function () {
    return Inertia::render('Security');
})->name('security');
});
Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

require __DIR__.'/auth.php';