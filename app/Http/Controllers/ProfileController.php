<?php

namespace App\Http\Controllers;

use App\Http\Requests\ProfileUpdateRequest;
use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Redirect;
use Inertia\Inertia;
use Inertia\Response;
use Illuminate\Support\Facades\Storage;

class ProfileController extends Controller
{
    /**
     * Display the user's profile form.
     */
    public function edit(Request $request): Response
    {
        return Inertia::render('Profile/Edit', [
            'mustVerifyEmail' => $request->user() instanceof MustVerifyEmail,
            'status' => session('status'),
        ]);
    }

    /**
     * Update the user's profile information.
     */
    public function update(Request $request)
{
    $request->validate([
        'name' => ['required', 'string', 'max:255'],
        'email' => ['required', 'email'],
        'adress' => ['string', 'nullable', 'max:256'],
    ]);

    $user = $request->user();
    $user->update($request->only('name', 'email', 'adress'));

    return redirect()->route('profile.edit')->with('status', 'profile-updated');
}

    /**
     * Delete the user's account.
     */
    public function destroy(Request $request): RedirectResponse
    {
        $request->validate([
            'password' => ['required', 'current_password'],
        ]);

        $user = $request->user();

        Auth::logout();

        $user->delete();

        $request->session()->invalidate();
        $request->session()->regenerateToken();

        return Redirect::to('/');
    }
    use Illuminate\Support\Facades\Storage;
    use Intervention\Image\Laravel\Facades\Image; // Laravel 11+/12 синтаксис
    
    public function updatePhoto(Request $request)
    {
        $request->validate([
            'photo' => ['required', 'image', 'max:2048'],
        ]);
    
        $user = $request->user();
    
        // Удаляем старые файлы (и оригинал, и миниатюру), если были и не дефолт
        if ($user->photo && Storage::disk('public')->exists($user->photo)) {
            Storage::disk('public')->delete($user->photo);
        }
        if (!empty($user->photo_thumb) && Storage::disk('public')->exists($user->photo_thumb)) {
            Storage::disk('public')->delete($user->photo_thumb);
        }
    
        // Сохраняем оригинал
        $originalPath = $request->file('photo')->store('profile-photos/original', 'public');
    
        // Генерируем миниатюру 64x64 WebP
        $img = Image::read($request->file('photo'))->cover(64, 64);
        $thumbPath = 'profile-photos/thumbs/'.pathinfo($originalPath, PATHINFO_FILENAME).'.webp';
        Storage::disk('public')->put($thumbPath, $img->toWebp(80)); // качество 80
    
        $user->photo = $originalPath;
        $user->photo_thumb = $thumbPath; // добавь колонку в users (string nullable)
        $user->save();
    
        return back()->with('success', 'Фото обновлено.');
    }
    
}
