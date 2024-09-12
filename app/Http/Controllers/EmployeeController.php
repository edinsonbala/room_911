<?php

namespace App\Http\Controllers;

use App\Models\Employee;
use App\Http\Requests\Employee\StoreRequest;
use Illuminate\Http\Request;
use Inertia\Inertia;

class EmployeeController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $search = $request->input('search', '');
    
        $employees = Employee::with('department')
        ->where(function ($query) use ($search) {
            $query->where('first_name', 'like', "%{$search}%")
                ->orWhere('last_name', 'like', "%{$search}%")
                ->orWhere('internal_id', 'like', "%{$search}%");
        })
        ->paginate(10);
    
        return Inertia::render('Employees/Index', [
            'employees' => $employees,
            'search' => $search,
        ]);
    }
    
    
    public function paginate(Request $request)
    {
        $employees = Employee::paginate(10); // Cambia el número de elementos por página si es necesario
        return response()->json($employees);
    }
    

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return Inertia::render('Employees/Create', []);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreRequest $request)
    {
        $employee = Employee::create($request->validated());
        return redirect()->route('employee.index')->with('success', 'Employee created successfully.');
    }

    /**
     * Display the specified resource.
     */
    public function show(Employee $employee)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Employee $employee)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Employee $employee)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Employee $employee)
    {
        //
    }
}
