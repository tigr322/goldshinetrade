<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Broadcast;
use Inertia\Inertia;

use App\Http\Controllers\MainController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\CardController;
use App\Http\Controllers\MessageController;
use App\Http\Controllers\WalletTopupController;
use App\Http\Controllers\Admin\AdminOfferController;
use App\Http\Controllers\Admin\AdminDataController;
use App\Http\Controllers\Trade\TradeController;
use App\Http\Controllers\Admin\AdminDashboardController;
use App\Http\Controllers\Admin\AdminUsersController;
use App\Models\UserCard;
use Illuminate\Support\Facades\Log;
use Illuminate\Foundation\Auth\EmailVerificationRequest;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;

Broadcast::routes(['middleware' => ['web', 'auth:sanctum']]);
Route::get('/test-mail', function () {
    Mail::raw('Это тестовое письмо от Laravel', function ($message) {
        $message->to('you@mailtrap.io') // подставь адрес из Mailtrap Inbox
                ->subject('Проверка SMTP');
    });

    return 'Письмо отправлено)';
});
// 🌐 Гостевая страница
Route::get('/', function () {
    return Inertia::render('Welcome', [
        'canLogin' => Route::has('login'),
        'canRegister' => Route::has('register'),
        'laravelVersion' => Application::VERSION,
        'phpVersion' => PHP_VERSION,
    ]);
})->name('Welcome');

// 📜 Статичные страницы
Route::get('/privacy', fn () => Inertia::render('Privacy/Privacy'))->name('privacy');
Route::get('/policy/offer', fn () => Inertia::render('Privacy/Offert'))->name('policy.offer');
Route::get('/policy/terms', fn () => Inertia::render('Privacy/Terms'))->name('policy.terms');
Route::get('/info', [MainController::class, 'learnmore'])->name('LearnMore');

// 🛡️ Защищённые страницы           'verified',

    Route::middleware([
        'auth:sanctum',
        config('jetstream.auth_session'),
    ])->group(function () {
    // 🌍 Главная, торговля, маршруты SPA
    Route::get('/dashboard', [MainController::class, 'index'])->name('dashboard');
    Route::get('/offers', [TradeController::class, 'index'])->name('offers.index');
    Route::post('/offers', [TradeController::class, 'store'])->name('offers.store');
    Route::post('/deals', [TradeController::class, 'buy'])->name('deals.buy');
    Route::get('/exchange', fn () => Inertia::render('Exchange'))->name('exchange');
    Route::get('/accounts', fn () => Inertia::render('Accounts'))->name('accounts');
    Route::get('/complaints', fn () => Inertia::render('Complaints'))->name('complaints');
    Route::get('/settings', fn () => Inertia::render('Settings'))->name('settings');
    Route::get('/help', fn () => Inertia::render('Help'))->name('help');
    Route::get('/security', fn () => Inertia::render('Security'))->name('security');

    // 📩 Сделки и сообщения
    Route::get('/deals/{deal}', [TradeController::class, 'show'])->name('deals.show');
    Route::post('/deals/{deal}/confirm', [TradeController::class, 'confirm'])->name('deals.confirm');
    Route::get('/deals/{deal}/messages', [MessageController::class, 'index'])->name('messages.index');
    Route::post('/deals/{deal}/messages', [MessageController::class, 'store'])->name('messages.store');
    Route::get('/mymessages', [MessageController::class, 'mymasseges'])->name('mymessages');
    Route::post('/messages/mark-read', [MessageController::class, 'markAsRead'])->name('messages.markRead');

    // 💳 Карты
    Route::bind('card', fn ($value) => UserCard::findOrFail($value));
    Route::get('/cards', [CardController::class, 'index'])->name('cards.index');
    Route::get('/cards/add', [CardController::class, 'create'])->name('cards.create');
    Route::post('/cards', [CardController::class, 'store'])->name('cards.store');
    Route::delete('/cards/{card}', [CardController::class, 'destroy'])->name('cards.destroy');

    // 💼 Профиль
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
    Route::post('/profile/photo', [ProfileController::class, 'updatePhoto'])->name('profile.photo');

    // 💰 Пополнение и оплата
    Route::get('/wallet/topup', [WalletTopupController::class, 'create'])->name('wallet.topup');
    Route::post('/wallet/topup', [WalletTopupController::class, 'store'])->name('wallet.topup.store');
   
    // ⚙️ Админ-панель
    Route::middleware(['admin_or_moder'])->prefix('admin')->name('admin.')->group(function () {
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
        Route::put('/game-types/{type}', [AdminDataController::class, 'updateGameType'])->name('game_types.update')->middleware('admin');
        Route::delete('/game-types/{type}', [AdminDataController::class, 'destroyGameType'])->name('game_types.destroy');

        Route::post('/payment-methods', [AdminDataController::class, 'storePaymentMethod'])->name('payment_methods.store');
        Route::put('/payment-methods/{paymentMethod}', [AdminDataController::class, 'updatePaymentMethod'])->name('payment_methods.update');
        Route::delete('/payment-methods/{paymentMethod}', [AdminDataController::class, 'destroyPaymentMethod'])->name('payment_methods.destroy');
    });
});
Route::post('/payment/callback', [WalletTopupController::class, 'handleCallback']);
    Route::get('/payment/success', fn () => 'Успех!')->name('payment.success');
Route::get('/payment/fail', fn () => 'Ошибка!')->name('payment.fail');
Route::middleware(['auth:sanctum'])->post('/email/verification-notification', function (Request $request) {
    if ($request->user()->hasVerifiedEmail()) {
        return response()->json(['message' => 'Email уже подтверждён.'], 400);
    }

    $request->user()->sendEmailVerificationNotification();

    return response()->json(['message' => 'Письмо отправлено.']);
})->name('verification.send');

// Обработка клика по ссылке
Route::get('/email/verify/{id}/{hash}', App\Http\Controllers\Auth\VerifyEmailController::class)
    ->middleware(['signed', 'throttle:6,1'])
    ->name('verification.verify');
// 🔐 Аутентификация
require __DIR__.'/auth.php';
