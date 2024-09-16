<?php

use App\Http\Controllers\EmployeeController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\UserController;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return Inertia::render('Welcome', [
        'canLogin' => Route::has('login'),
        'canRegister' => Route::has('register'),
        'laravelVersion' => Application::VERSION,
        'phpVersion' => PHP_VERSION,
    ]);
});

Route::get('/dashboard', function () {
    return Inertia::render('Dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

Route::get('/employees', [EmployeeController::class, 'auth'])->name('employee.showAuth');
Route::post('/employees', [EmployeeController::class, 'auth'])->name('employee.auth');
Route::prefix('dashboard')->middleware('auth')->group(function () {
    Route::get('/employees', [EmployeeController::class, 'index'])->name('employee.index');
    Route::get('/employees/create', [EmployeeController::class, 'create'])->name('employee.create');
    Route::post('/employees', action: [EmployeeController::class, 'store'])->name('employee.store');
    Route::get('/employees/edit/{id}', [EmployeeController::class, 'edit'])->name('employee.edit');
    Route::put('/employees/{id}', [EmployeeController::class, 'update'])->name('employee.update');
    Route::post('/employees/{id}/toggle-room-access', [EmployeeController::class, 'toggleRoomAccess'])->name('employees.toggle-room-access');
    Route::get('employees/{id}/history-pdf', [EmployeeController::class, 'historyPdf'])->name('employee.historyPdf');
    Route::delete('/employees/{id}', [EmployeeController::class, 'destroy'])->name('employee.destroy');
    Route::post('/employees/import-csv', [EmployeeController::class, 'importCsv'])->name('employee.importCsv');
    Route::get('/users', [UserController::class, 'index'])->name('user.index');
    Route::get('/users/create', [UserController::class, 'create'])->name(name: 'user.create');
    Route::post('/users', action: [UserController::class, 'store'])->name('user.store');
    Route::get('/users/{id}', [UserController::class, 'edit'])->name('user.edit');
    Route::put('/users/{id}', [UserController::class, 'update'])->name('user.update');
});
require __DIR__.'/auth.php';
