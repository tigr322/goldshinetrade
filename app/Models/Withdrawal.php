<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Withdrawal extends Model
{
    use HasFactory;

    protected $fillable = ['user_id', 'amount', 'method', 'details', 'status'];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }
}


