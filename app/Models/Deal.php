<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Deal extends Model
{
    protected $fillable = [
        'buyer_id', 'offer_id', 'quantity', 'total_price', 'status', 'started_at', 'completed_at'
    ];

    public function buyer()
    {
        return $this->belongsTo(User::class, 'buyer_id');
    }

    public function offer()
    {
        return $this->belongsTo(Offer::class);
    }

    public function messages()
    {
        return $this->hasMany(Message::class);
    }

    public function reviews()
    {
        return $this->hasMany(Review::class);
    }

    public function categories()
    {
        return $this->morphToMany(Category::class, 'categoryable');
    }
}
