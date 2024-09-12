<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Employee extends Model
{
    use HasFactory;
    protected $fillable = [
        'first_name',
        'last_name',
        'internal_id',
        'department_id',
        'room_access',
    ];
    protected $casts = [
        'room_access' => 'boolean',
    ];
    public function department()
    {
        return $this->belongsTo(Department::class);
    }
}
