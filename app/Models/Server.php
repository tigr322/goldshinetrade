<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
class Server extends Model
{
    use HasFactory;
    protected $fillable = ['name', 'game_id'];

    public function game(): BelongsTo
    {
        return $this->belongsTo(Game::class);
    }
}