<?php

namespace App\Http\Controllers;



use App\Models\Message;
use App\Models\Deal;
use App\Models\MessageRead;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Events\NewMessageSent; 
use Inertia\Inertia;
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

        broadcast(new NewMessageSent($message));
        return response()->json($message->load('user'));
    }
    public function markAsRead(Request $request)
    {
        $user = auth()->user();
        $messageIds = $request->input('message_ids', []);
    
        $now = now();
    
        foreach ($messageIds as $id) {
            MessageRead::firstOrCreate([
                'message_id' => $id,
                'user_id' => $user->id,
            ], [
                'read_at' => $now,
            ]);
        }
    
        return response()->noContent();
    }
    public function index(Deal $deal)
    {
        return Message::with('user')->where('deal_id', $deal->id)->latest()->get();
    }
    public function mymasseges()
{
    $userId = Auth::id();

    return Inertia::render('Messages/Index', [
        'messages' => Message::with(['user', 'deal'])
            ->whereHas('deal', function ($query) use ($userId) {
                $query->where('buyer_id', $userId)
                      ->orWhereHas('offer', function ($q) use ($userId) {
                          $q->where('user_id', $userId);
                      });
            })
            ->latest()
            ->get(),
    ]);
}
    
}