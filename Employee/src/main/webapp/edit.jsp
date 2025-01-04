<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Employee</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white">
            <h2 class="text-center">Edit Employee Record</h2>
        </div>
        <div class="card-body">
            <%
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;
                String url = "jdbc:mysql://localhost:3306/employee";
                String dbUser = "root";
                String dbPassword = "";

                int id = Integer.parseInt(request.getParameter("id"));
                String name = "", department = "", salary = "";

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection(url, dbUser, dbPassword);
                    String sql = "SELECT * FROM employee_table WHERE id = ?";
                    stmt = conn.prepareStatement(sql);
                    stmt.setInt(1, id);
                    rs = stmt.executeQuery();

                    if (rs.next()) {
                        name = rs.getString("name");
                        department = rs.getString("department");
                        salary = rs.getString("salary");
                    } else {
                        out.println("<div class='alert alert-danger'>No employee found with the given ID.</div>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
            <form action="updateemployee.jsp" method="post" class="needs-validation" novalidate>
                <input type="hidden" name="id" value="<%= id %>">
                <div class="mb-3">
                    <label for="name" class="form-label">Name</label>
                    <input type="text" id="name" name="name" class="form-control" value="<%= name %>" required>
                    <div class="invalid-feedback">Please provide a name.</div>
                </div>
                <div class="mb-3">
                    <label for="department" class="form-label">Department</label>
                    <input type="text" id="department" name="department" class="form-control" value="<%= department %>" required>
                    <div class="invalid-feedback">Please provide a department.</div>
                </div>
                <div class="mb-3">
                    <label for="salary" class="form-label">Salary</label>
                    <input type="text" id="salary" name="salary" class="form-control" value="<%= salary %>" required>
                    <div class="invalid-feedback">Please provide a valid salary.</div>
                </div>
                <button type="submit" class="btn btn-secondary w-100">Update</button>
            </form>
            <a href="View.jsp" class="btn btn-success mt-3">Back to Employee Records</a>
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
