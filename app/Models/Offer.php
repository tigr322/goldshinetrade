<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Support\Collection;


class Offer extends Model
{
    use HasFactory;
    protected $fillable = [
        'user_id',
        'category_id',
        'game_category_id',
        'game_id',
        'server_id',
        'title',
        'description',
        'price',
        'quantity',
        'is_active',
    ];
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }
    public function gameCategoryIds(): Collection
    {
        return $this->server?->game?->categories->pluck('id') ?? collect();
    }
    public function category(): BelongsTo
    {
        return $this->belongsTo(Category::class);
    }

    public function server(): BelongsTo
    {
        return $this->belongsTo(Server::class);
    }

    public function deals(): HasMany
    {
        return $this->hasMany(Deal::class);
    }
}

