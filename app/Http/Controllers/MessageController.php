<?php

namespace App\Http\Controllers;



use App\Models\Message;
use App\Models\Deal;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Events\MessageSent;

class MessageController extends Controller
{
    public function store(Request $request, Deal $deal)
    {
        $request->validate(['content' => 'required|string']);

        $message = Message::create([
            'deal_id' => $deal->id,
            'user_id' => Auth::id(),
            'content' => $request->content,
        ]);

        broadcast(new MessageSent($message))->toOthers();

        return response()->json($message->load('user'));
    }

    public function index(Deal $deal)
    {
        return Message::with('user')->where('deal_id', $deal->id)->latest()->get();
    }
}