<?php

use App\Http\Controllers\MainController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\CardController;
use App\Http\Controllers\MessageController;
use App\Http\Controllers\WalletTopupController;
use App\Http\Controllers\Admin\AdminOfferController;
use App\Http\Controllers\Admin\AdminDataController;
use Illuminate\Foundation\Application;
use App\Http\Controllers\Trade\TradeController;
use App\Http\Controllers\Admin\AdminDashboardController;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;
use App\Http\Controllers\Admin\AdminUsersController;
use App\Models\UserCard;

Route::get('/', function () {
    return Inertia::render('Welcome', [
        'canLogin' => Route::has('login'),
        'canRegister' => Route::has('register'),
        'laravelVersion' => Application::VERSION,
        'phpVersion' => PHP_VERSION,
    ]);
});


Route::middleware(['auth'])->group(function () {
    Route::get('/deals/{deal}', [TradeController::class, 'show'])->name('deals.show');
    Route::post('/deals/{deal}/confirm', [TradeController::class, 'confirm'])->name('deals.confirm');
    Route::post('/deals/{deal}/messages', [MessageController::class, 'store'])->name('messages.store');
    Route::get('/deals/{deal}/messages', [MessageController::class, 'index'])->name('messages.index');
    Route::get('/mymessages', [MessageController::class, 'mymasseges'])->name('mymessages');
    Route::get('/privacy', fn () => Inertia::render('Privacy/Privacy'))->name('privacy');
    Route::get('/policy/offer', fn() => Inertia::render('Privacy/Offert'))->name('policy.offer');
Route::get('/policy/terms', fn() => Inertia::render('Privacy/Terms'))->name('policy.terms');
});

Route::middleware(['auth', 'admin_or_moder'])->prefix('admin')->name('admin.')->group(function () {
    Route::get('/dashboard', [AdminDashboardController::class, 'index'])->name('dashboard');
    Route::get('/users', [AdminUsersController::class, 'index'])->name('users.index')->middleware('admin');
    Route::patch('/users/{user}/role', [AdminUsersController::class, 'updateRole'])->name('users.updateRole')->middleware('admin');
    Route::get('/offers', [AdminOfferController::class, 'index'])->name('offers.index');
Route::get('/offers/{offer}/edit', [AdminOfferController::class, 'edit'])->name('offers.edit')->middleware('admin');
Route::put('/offers/{offer}', [AdminOfferController::class, 'update'])->name('offers.update')->middleware('admin');
Route::delete('/offers/{offer}', [AdminOfferController::class, 'destroy'])->name('offers.destroy')->middleware('admin');


Route::get('/data', [AdminDataController::class, 'index'])->name('data.index');

Route::post('/categories', [AdminDataController::class, 'storeCategory'])->name('categories.store');
Route::put('/categories/{category}', [AdminDataController::class, 'updateCategory'])->name('categories.update');
Route::delete('/categories/{category}', [AdminDataController::class, 'destroyCategory'])->name('categories.destroy');

Route::post('/games', [AdminDataController::class, 'storeGame'])->name('games.store');
Route::put('/games/{game}', [AdminDataController::class, 'updateGame'])->name('games.update');
Route::delete('/games/{game}', [AdminDataController::class, 'destroyGame'])->name('games.destroy');

Route::post('/servers', [AdminDataController::class, 'storeServer'])->name('servers.store');
Route::put('/servers/{server}', [AdminDataController::class, 'updateServer'])->name('servers.update');
Route::delete('/servers/{server}', [AdminDataController::class, 'destroyServer'])->name('servers.destroy');
Route::post('/game-types', [AdminDataController::class, 'storeGameType'])->name('game_types.store');
Route::delete('/game-types/{type}', [AdminDataController::class, 'destroyGameType'])->name('game_types.destroy');
Route::post('/payment-methods', [AdminDataController::class, 'storePaymentMethod'])->name('payment_methods.store');
Route::put('/payment-methods/{paymentMethod}', [AdminDataController::class, 'updatePaymentMethod'])->name('payment_methods.update');
Route::delete('/payment-methods/{paymentMethod}', [AdminDataController::class, 'destroyPaymentMethod'])->name('payment_methods.destroy');
    // Добавь сюда другие админ-маршруты
});
Route::middleware(['auth'])->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::get('/offers', [TradeController::class, 'index'])->name('offers.index');
   Route::post('/offers', [TradeController::class, 'store'])->name('offers.store');
    Route::post('/deals', [TradeController::class, 'buy'])->name('deals.buy'); 
Route::get('/dashboard', [MainController::class, 'index'])->name('dashboard');
Route::get('/exchange', function () {
    return Inertia::render('Exchange');
})->name('exchange');

// Администрирование


// Мои счетаfdfdfddsdsd
Route::get('/accounts', function () {
    return Inertia::render('Accounts');
})->name('accounts');

// Жалобывыввы
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
    Route::post('/profile/photo', [ProfileController::class, 'updatePhoto'])->name('profile.photo')->middleware('auth');
});
// routes/web.php
Route::bind('card', function ($value) {
    return UserCard::findOrFail($value);
});
Route::middleware(['auth'])->group(function () {
    Route::get('/cards', [CardController::class, 'index'])->name('cards.index');
    Route::get('/cards/add', [CardController::class, 'create'])->name('cards.create');
    Route::post('/cards', [CardController::class, 'store'])->name('cards.store');
    Route::delete('/cards/{card}', [CardController::class, 'destroy'])->name('cards.destroy');});
    
    Route::middleware(['auth'])->group(function () {
    Route::get('/messages', [\App\Http\Controllers\MessageController::class, 'index'])->name('messages.index');
});

Route::middleware(['auth'])->group(function () {
    Route::get('/wallet/topup', [WalletTopupController::class, 'create'])->name('wallet.topup');
    Route::post('/wallet/topup', [WalletTopupController::class, 'store'])->name('wallet.topup.store');
});
require __DIR__.'/auth.php';