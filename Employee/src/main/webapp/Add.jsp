<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Employee Record</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white">
            <h2 class="text-center">Add Employee Record</h2>
        </div>
        <div class="card-body">
            <%
                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    String Name = request.getParameter("Name");
                    String Department = request.getParameter("Department");
                    double Salary = Double.parseDouble(request.getParameter("Salary"));

                    Connection conn = null;
                    PreparedStatement stmt = null;
                    String url = "jdbc:mysql://localhost:3306/employee"; 
                    String dbUser = "root"; 
                    String dbPassword = ""; 
                    try {
                        
                        Class.forName("com.mysql.jdbc.Driver");
                        conn = DriverManager.getConnection(url, dbUser, dbPassword);
                        String sql = "INSERT INTO employee_table (Name, Department, Salary) VALUES (?, ?, ?)";
                        stmt = conn.prepareStatement(sql);
                        stmt.setString(1, Name);
                        stmt.setString(2, Department);
                        stmt.setDouble(3, Salary);

                        int rowsAffected = stmt.executeUpdate();
                        if (rowsAffected > 0) {
                            out.println("<div class='alert alert-success'>Employee record added successfully!</div>");
                        } else {
                            out.println("<div class='alert alert-danger'>Failed to add the employee record.</div>");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
                    } finally {
                        try {
                            if (stmt != null) stmt.close();
                            if (conn != null) conn.close();
                        } catch (SQLException se) {
                            se.printStackTrace();
                        }
                    }
                }
            %>
            <form action="Add.jsp" method="POST" class="needs-validation" novalidate>
                <div class="mb-3">
                    <label for="Name" class="form-label">Name</label>
                    <input type="text" class="form-control" id="Name" name="Name" required>
                    <div class="invalid-feedback">Please provide a name.</div>
                </div>
                <div class="mb-3">
                    <label for="Department" class="form-label">Department</label>
                    <input type="text" class="form-control" id="Department" name="Department" required>
                    <div class="invalid-feedback">Please provide a department.</div>
                </div>
                <div class="mb-3">
                    <label for="Salary" class="form-label">Salary</label>
                    <input type="number" step="0.01" class="form-control" id="Salary" name="Salary" required>
                    <div class="invalid-feedback">Please provide a valid salary.</div>
                </div>
                <button type="submit" class="btn btn-secondary w-100">Add Record</button>
            </form>
            <br>
            <button class="btn btn-success" onclick="window.location.href='Index.html'">Back to Home page</button>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    
    (function () {
        'use strict'
        var forms = document.querySelectorAll('.needs-validation')
        Array.prototype.slice.call(forms).forEach(function (form) {
            form.addEventListener('submit', function (event) {
                if (!form.checkValidity()) {
                    event.preventDefault()
                    event.stopPropagation()
                }
                form.classList.add('was-validated')
            }, false)
        })
    })()
</script>

</body>
</html>
