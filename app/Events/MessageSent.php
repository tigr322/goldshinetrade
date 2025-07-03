<?php
namespace App\Events;

use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;
use App\Models\Message;

class MessageSent implements ShouldBroadcast
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public $message;

    public function __construct(Message $message)
    {
        $this->message = $message->load('user'); // если нужна инфа о пользователе
    }

    public function broadcastOn()
    {
        return new PrivateChannel('deal.' . $this->message->deal_id);
    }

    public function broadcastWith()
    {
        return [
            'message' => $this->message->toArray(),
        ];
    }
}