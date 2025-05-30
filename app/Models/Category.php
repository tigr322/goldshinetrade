<?php

// app/Models/Category.php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Category extends Model
{
    use HasFactory;

    protected $fillable = ['name'];

    public function games(): HasMany
    {
        return $this->hasMany(Game::class);
    }

    public function offers(): HasMany
    {
        return $this->hasMany(Offer::class);
    }
}
