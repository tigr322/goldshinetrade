<?php

namespace App\Http\Controllers;





use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;
use App\Models\Message;

class MessageController extends Controller
{
    public function index()
    {
        $messages = Message::with(['user', 'deal'])
            ->where('user_id', Auth::id())
            ->latest()
            ->get();

        return Inertia::render('Messages/Index', [
            'messages' => $messages,
        ]);
    }
}