<html>
<head>
    <title>Access History</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
        }
        th {
            background-color: #f4f4f4;
        }
    </style>
</head>
<body>
    <h1>Access History for {{ $employee->first_name }} {{ $employee->last_name }}</h1>
    <table>
        <thead>
            <tr>
                <th>Date</th>
                <th>Status</th>
                <th>Result Message</th>
            </tr>
        </thead>
        <tbody>
            @foreach ($accessAttempts as $attempt)
                <tr>
                    <td>{{ $attempt->created_at->format('Y-m-d H:i:s') }}</td>
                    <td>{{ $attempt->was_successful ? 'Approved' : 'Denied' }}</td>
                    <td>{{ $attempt->result_message }}</td>
                </tr>
            @endforeach
        </tbody>
    </table>
</body>
</html>
