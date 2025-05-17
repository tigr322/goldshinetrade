<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\MorphToMany;

class Category extends Model
{
    protected $fillable = ['name', 'slug', 'description', 'parent_id'];

    public function parent()
    {
        return $this->belongsTo(Category::class, 'parent_id');
    }

    public function children()
    {
        return $this->hasMany(Category::class, 'parent_id');
    }

    public function offers(): MorphToMany
    {
        return $this->morphedByMany(Offer::class, 'categoryable');
    }

    public function deals(): MorphToMany
    {
        return $this->morphedByMany(Deal::class, 'categoryable');
    }
}
