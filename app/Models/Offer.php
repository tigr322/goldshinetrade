<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Offer extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'category_id',
        'game_id',
        'server_id',
        'title',
        'description',
        'full_description',
        'price',
        'quantity',
        'is_active',
        'fee_model',
        'fee_buyer_percent',
        'fee_seller_percent',
    ];
    
    protected $casts = [
        'price' => 'decimal:2',
        'fee_buyer_percent'  => 'float',
        'fee_seller_percent' => 'float',
    ];
    

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function category(): BelongsTo
    {
        return $this->belongsTo(Category::class);
    }

    public function game(): BelongsTo
    {
        return $this->belongsTo(Game::class);
    }

    public function server(): BelongsTo
    {
        return $this->belongsTo(Server::class);
    }

    public function deals(): HasMany
    {
        return $this->hasMany(Deal::class);
    }
    public function getBuyerFinalPriceAttribute()
    {
        if ($this->fee_model === 'buyer_pays') {
            return round($this->price * (1 + $this->fee_buyer_percent / 100), 2);
        }
        return $this->price;
    }

    public function getSellerReceiveAmountAttribute()
    {
        if ($this->fee_model === 'seller_pays') {
            return round($this->price * (1 - $this->fee_seller_percent / 100), 2);
        }
        return $this->price;
    }

}

