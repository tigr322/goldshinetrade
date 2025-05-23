<?php

namespace App\Models;



use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Game extends Model
{
    use HasFactory;

    protected $fillable = ['name', 'category_id', 'game_type_id'];

    public function category(): BelongsTo
    {
        return $this->belongsTo(Category::class);
    }

    public function gameType(): BelongsTo
    {
        return $this->belongsTo(GameType::class);
    }

    public function servers(): HasMany
    {
        return $this->hasMany(Server::class);
    }

    public function offers(): HasMany
    {
        return $this->hasMany(Offer::class);
    }
}