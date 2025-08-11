<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Deal extends Model
{
    use HasFactory;

    protected $fillable = [
        'offer_id', 'buyer_id',
        'quantity', 'total_price',
        'status', 'escrow_amount',   // <-- используем escrow_amount
        'confirmed_at', 'released_at', 'canceled_at',
    ];

    protected $casts = [
        'escrow_amount' => 'decimal:2',
        'confirmed_at'  => 'datetime',
        'released_at'   => 'datetime',
        'canceled_at'   => 'datetime',
    ];

    public function offer(): BelongsTo
    {
        return $this->belongsTo(Offer::class);
    }

    public function buyer(): BelongsTo
    {
        return $this->belongsTo(User::class, 'buyer_id');
    }

    public function paymentMethod(): BelongsTo
    {
        return $this->belongsTo(PaymentMethod::class);
    }

    public function messages(): HasMany
    {
        return $this->hasMany(Message::class);
    }
}
