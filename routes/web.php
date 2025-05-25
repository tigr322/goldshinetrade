<?php

use App\Http\Controllers\MainController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\CardController;
use App\Http\Controllers\WalletTopupController;
use App\Http\Controllers\Admin\AdminOfferController;

use Illuminate\Foundation\Application;
use App\Http\Controllers\Trade\TradeController;
use App\Http\Controllers\Admin\AdminDashboardController;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;
use App\Http\Controllers\Admin\AdminUsersController;


Route::get('/', function () {
    return Inertia::render('Welcome', [
        'canLogin' => Route::has('login'),
        'canRegister' => Route::has('register'),
        'laravelVersion' => Application::VERSION,
        'phpVersion' => PHP_VERSION,
    ]);
});
Route::middleware(['auth', 'admin'])->prefix('admin')->name('admin.')->group(function () {
    Route::get('/dashboard', [AdminDashboardController::class, 'index'])->name('dashboard');
    Route::get('/users', [AdminUsersController::class, 'index'])->name('users.index');
    Route::patch('/users/{user}/role', [AdminUsersController::class, 'updateRole'])->name('users.updateRole');
    Route::get('/offers', [AdminOfferController::class, 'index'])->name('offers.index');
Route::get('/offers/{offer}/edit', [AdminOfferController::class, 'edit'])->name('offers.edit');
Route::put('/offers/{offer}', [AdminOfferController::class, 'update'])->name('offers.update');
Route::delete('/offers/{offer}', [AdminOfferController::class, 'destroy'])->name('offers.destroy');
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
Route::middleware(['auth'])->group(function () {
    Route::get('/cards', [CardController::class, 'index'])->name('cards.index');
    Route::get('/cards/add', [CardController::class, 'create'])->name('cards.create');
    Route::post('/cards', [CardController::class, 'store'])->name('cards.store');
    Route::delete('/cards/{card}', [CardController::class, 'destroy'])->name('cards.destroy');

});
Route::middleware(['auth'])->group(function () {
    Route::get('/messages', [\App\Http\Controllers\MessageController::class, 'index'])->name('messages.index');
});

Route::middleware(['auth'])->group(function () {
    Route::get('/wallet/topup', [WalletTopupController::class, 'create'])->name('wallet.topup');
    Route::post('/wallet/topup', [WalletTopupController::class, 'store'])->name('wallet.topup.store');
});
require __DIR__.'/auth.php';