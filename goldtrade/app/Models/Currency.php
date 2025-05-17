<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Currency extends Model
{
    protected $fillable = ['name', 'game_name'];

    public function offers(): HasMany
    {
        return $this->hasMany(Offer::class);
    }
}
