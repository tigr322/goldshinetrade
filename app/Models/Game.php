<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
class Game extends Model
{
    use HasFactory;
    protected $fillable = ['name'];
    protected $table = 'games';
    public function categories(): BelongsToMany
    {
        return $this->belongsToMany(Category::class, 'game_category');
    }

    public function servers(): HasMany
    {
        return $this->hasMany(Server::class);
    }
}