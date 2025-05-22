<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

class Category extends Model
{
    use HasFactory;
    protected $fillable = ['name'];

    public function games(): BelongsToMany
    {
        return $this->belongsToMany(Game::class, 'game_category');
    }

    public function offers(): HasMany
    {
        return $this->hasMany(Offer::class);
    }
}