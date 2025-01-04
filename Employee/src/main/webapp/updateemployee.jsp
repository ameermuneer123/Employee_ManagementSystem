<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Update Employee</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white">
            <h2 class="text-center">Update Employee Record</h2>
        </div>
        <div class="card-body">
            <%
                Connection conn = null;
                PreparedStatement ps = null;
                String url = "jdbc:mysql://localhost:3306/employee";
                String dbUser = "root";
                String dbPassword = "";

                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name");
                String department = request.getParameter("department");
                double salary = Double.parseDouble(request.getParameter("salary"));

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection(url, dbUser, dbPassword);

                    String sql = "UPDATE employee_table SET name = ?, department = ?, salary = ? WHERE id = ?";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, name);
                    ps.setString(2, department);
                    ps.setDouble(3, salary);
                    ps.setInt(4, id);

                    int rowsUpdated = ps.executeUpdate(); 

                    if (rowsUpdated > 0) {
                        out.println("<div class='alert alert-success'>Employee record updated successfully!</div>");
                    } else {
                        out.println("<div class='alert alert-danger'>Could not update the Employee record.</div>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
                } finally {
                    if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
            <a href="View.jsp" class="btn btn-secondary mt-3">Back to Employee Records</a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
