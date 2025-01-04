<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>View Employee Records</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white">
            <h2 class="text-center">Employee Records</h2>
        </div>
        <div class="card-body">
            <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                String url = "jdbc:mysql://localhost:3306/employee";
                String dbUser = "root";
                String dbPassword = "";
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    conn = DriverManager.getConnection(url, dbUser, dbPassword);
                    String sql = "SELECT * FROM employee_table";
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(sql);

                    out.println("<table class='table table-striped table-hover'>");
                    out.println("<thead class='table-dark'>");
                    out.println("<tr><th>ID</th><th>Name</th><th>Department</th><th>Salary</th><th>Actions</th></tr>");
                    out.println("</thead><tbody>");

                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String Name = rs.getString("Name");
                        String Department = rs.getString("Department");
                        double Salary = rs.getDouble("Salary");

                        out.println("<tr>");
                        out.println("<td>" + id + "</td>");
                        out.println("<td>" + Name + "</td>");
                        out.println("<td>" + Department + "</td>");
                        out.println("<td>" + Salary + "</td>");
                        out.println("<td>");
                        out.println("<a href='edit.jsp?id=" + id + "' class='btn btn-sm btn-secondary me-2'>Edit</a>");
                        out.println("<a href='delete.jsp?id=" + id + "' class='btn btn-sm btn-danger' onclick='return confirm(\"Are you sure you want to delete this record?\")'>Delete</a>");
                        out.println("</td>");
                        out.println("</tr>");
                    }

                    out.println("</tbody></table>");

                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException se) {
                        se.printStackTrace();
                    }
                }
            %>
            <button class="btn btn-success" onclick="window.location.href='Index.html'">Back to Home page</button>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
