<?php

namespace App\Http\Controllers;

use App\Models\Employee;
use App\Models\Department;
use App\Models\AccessAttempt;
use App\Http\Requests\Employee\StoreRequest;
use App\Http\Requests\Employee\UpdateRequest;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Barryvdh\DomPDF\Facade\Pdf;

class EmployeeController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $search = $request->input('search', '');
        $departmentId = $request->input('department_id', null);
        $startDate = $request->input('start_date', null);
        $endDate = $request->input('end_date', null);
        $perPage = 10;
    
        $accessAttemptEmployeeIds = [];
    
        if (!empty($startDate) && !empty($endDate)) {
            $startDate = \Carbon\Carbon::parse($startDate)->startOfDay();
            $endDate = \Carbon\Carbon::parse($endDate)->endOfDay();
    
            $accessAttemptEmployeeIds = AccessAttempt::query()
                ->whereBetween('created_at', [$startDate, $endDate])
                ->pluck('employee_id');
        }
    
        $employeesQuery = Employee::with('department')
            ->withCount('accessAttempts');
    
        if (!empty($accessAttemptEmployeeIds)) {
            $employeesQuery->whereIn('id', $accessAttemptEmployeeIds);
        }
    
        if (!empty($search)) {
            $employeesQuery->where(function ($query) use ($search) {
                $query->where('first_name', 'like', "%{$search}%")
                      ->orWhere('last_name', 'like', "%{$search}%")
                      ->orWhere('internal_id', 'like', "%{$search}%");
            });
        }
    
        if (!empty($departmentId)) {
            $employeesQuery->where('department_id', $departmentId);
        }
    
        $employees = $employeesQuery->paginate($perPage);
    
        $departments = Department::all()->map(function ($department) {
            return [
                'value' => $department->id,
                'name' => $department->name,
            ];
        });
    
        return Inertia::render('Employees/Index', [
            'employees' => $employees->items(),
            'currentPage' => $employees->currentPage(),
            'lastPage' => $employees->lastPage(),
            'total' => $employees->total(),
            'departments' => $departments,
        ]);
    }
    
    
    

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $departments = Department::all()->map(function ($department) {
            return [
                'value' => $department->id,
                'name' => $department->name,
            ];
        });
        return Inertia::render('Employees/Create', ['departments'=>$departments]);
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
    public function edit($id)
    {
        $employee = Employee::with('department')->findOrFail($id);
        $departments = Department::all()->map(function ($department) {
            return [
                'value' => $department->id,
                'name' => $department->name,
            ];
        });
        return Inertia::render('Employees/Edit', [
            'employee' => $employee, 
            'departments'=>$departments
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateRequest $request, $id)
    {
        $employee = Employee::findOrFail($id);
        $validatedData = $request->validated();
        $employee->update($request->validated());
        return redirect()->route('employee.index')->with('success', 'Employee updated successfully.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy( $id)
    {
        $employee = Employee::findOrFail($id);
        $employee->delete();
        
        return redirect()->route('employee.index')->with('success', 'Employee deleted successfully.');
    }
    public function showAuth()
{ 
    return Inertia::render('Employees/Auth', [ ]);
   
}
  
public function auth(Request $request)
{
    $internalId = $request->input('internal_id');
    $employee = Employee::where('internal_id', $internalId)->first();

    if ($employee) {
        $accessAttempt = new AccessAttempt();
        $accessAttempt->employee_id = $employee->id;
        
        if ($employee->room_access) {
            $accessAttempt->was_successful = true;
            $accessAttempt->result_message = 'Access granted';
            $accessAttempt->save();
            return Inertia::render('Employees/Auth', [
                'success' => true,
                'message' => 'Access granted'
            ]);
        } else {
            $accessAttempt->was_successful = false;
            $accessAttempt->result_message = 'Room access is not allowed';
            $accessAttempt->save();
            return Inertia::render('Employees/Auth', [
                'success' => false,
                'message' => 'Room access is not allowed'
            ]);
        }
    } else {
       
        return Inertia::render('Employees/Auth', [
            'success' => false,
            'message' => 'Invalid internal ID'
        ]);
    }
}
    public function toggleRoomAccess(Request $request, $id)
    {
        $employee = Employee::findOrFail($id);
        $employee->room_access = !$employee->room_access;
        $employee->save();
        return redirect()->route('employee.index')->with('success', 'Room access status updated successfully.');
    }
    public function historyPdf($id)
    {
        $employee = Employee::findOrFail($id);
        $accessAttempts = AccessAttempt::where('employee_id', $id)->get();
        $pdf = PDF::loadView('pdf.history', [
            'employee' => $employee,
            'accessAttempts' => $accessAttempts
        ]);

        return $pdf->download('history-' . $employee->id . '.pdf');
    }
    public function importCsv(Request $request)
    {
        $request->validate([
            'csv_file' => 'required|mimes:csv,txt',
        ]);
    
        $file = $request->file('csv_file');
    
        if (($handle = fopen($file->getRealPath(), 'r')) !== false) {
            $header = fgetcsv($handle, 1000, ',');
    
            while (($data = fgetcsv($handle, 1000, ',')) !== false) {
                if (Employee::where('internal_id', $data[2])->exists()) {
                    return redirect()->route('employee.index')->with('error', 'Duplicate internal_id found: ' . $data[2]);
                }
    
                $roomAccess = filter_var($data[4], FILTER_VALIDATE_BOOLEAN, FILTER_NULL_ON_FAILURE);
                $roomAccess = $roomAccess === null ? 0 : (int) $roomAccess;
    
                Employee::create([
                    'first_name' => $data[0],
                    'last_name' => $data[1],
                    'internal_id' => $data[2],
                    'department_id' => $data[3],
                    'room_access' => $roomAccess,
                ]);
            }
    
            fclose($handle);
        }
    
        return redirect()->route('employee.index')->with('success', 'Employees imported successfully.');
    }
    

}
