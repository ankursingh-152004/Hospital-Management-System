<%-- <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.hms.model.Doctor" %>
<% if (session.getAttribute("adminUser") == null) { response.sendRedirect("../login.jsp"); return; } %>
<!DOCTYPE html>
<html>
<head>
  <title>Doctors</title>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
  <div class="navbar">
    <h2>Hospital Management System</h2>
    <div>
      <a href="dashboard.jsp">Dashboard</a>
      <a href="logout">Logout</a>
    </div>
  </div>
  <div class="container">
    <div class="card">
      <div class="top-actions">
        <a class="btn" href="doctor?action=add">+ Add Doctor</a>
      </div>
      <table>
        <tr><th>ID</th><th>Name</th><th>Specialization</th><th>Phone</th><th>Email</th><th>Actions</th></tr>
        <%
          List<Doctor> doctors = (List<Doctor>) request.getAttribute("doctors");
          if (doctors != null) {
            for (Doctor d : doctors) {
        %>
        <tr>
          <td><%= d.getId() %></td>
          <td><%= d.getName() %></td>
          <td><%= d.getSpecialization() %></td>
          <td><%= d.getPhone() %></td>
          <td><%= d.getEmail() %></td>
          <td>
            <a href="doctor?action=edit&id=<%= d.getId() %>">Edit</a> |
            <a href="doctor?action=delete&id=<%= d.getId() %>" onclick="return confirm('Delete this doctor?');">Delete</a>
          </td>
        </tr>
        <% } } %>
      </table>
    </div>
  </div>
</body>
</html>
 --%>
 
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.hms.model.Doctor" %>

<%
    if (session.getAttribute("adminUser") == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
@SuppressWarnings("unchecked")
    List<Doctor> doctors = (List<Doctor>) request.getAttribute("doctors");
    int doctorCount = doctors != null ? doctors.size() : 0;
%>

<!DOCTYPE html>
<html>
<head>
    <title>Doctors | Hospital Management System</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <style>
        /* ================================
           DOCTORS PAGE
           ================================ */

        .doctors-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 35px 25px;
        }

        /* Page Header */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            margin-bottom: 28px;
        }

        .page-heading {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .page-icon {
            width: 55px;
            height: 55px;
            border-radius: 14px;
            background: linear-gradient(135deg, #0f766e, #14b8a6);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 27px;
            box-shadow: 0 8px 20px rgba(15, 118, 110, 0.18);
        }

        .page-heading h1 {
            margin: 0;
            color: #123047;
            font-size: 28px;
            font-weight: 700;
        }

        .page-heading p {
            margin: 5px 0 0;
            color: #718096;
            font-size: 14px;
        }

        /* Doctor Count */
        .doctor-count {
            background: #ecfdf5;
            color: #047857;
            padding: 8px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
            white-space: nowrap;
        }

        /* Main Card */
        .doctors-card {
            background: #ffffff;
            border-radius: 18px;
            border: 1px solid #e6edf2;
            box-shadow: 0 8px 30px rgba(15, 23, 42, 0.06);
            overflow: hidden;
        }

        /* Card Header */
        .table-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 22px 25px;
            border-bottom: 1px solid #edf2f7;
            gap: 15px;
        }

        .table-header h3 {
            margin: 0;
            color: #1e293b;
            font-size: 18px;
        }

        .table-header p {
            margin: 4px 0 0;
            color: #94a3b8;
            font-size: 13px;
        }

        /* Add Doctor Button */
        .add-doctor-btn {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            padding: 11px 18px;
            border-radius: 9px;
            background: linear-gradient(135deg, #0f766e, #0d9488);
            color: white !important;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            box-shadow: 0 5px 14px rgba(13, 148, 136, 0.20);
            transition: all 0.2s ease;
        }

        .add-doctor-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 18px rgba(13, 148, 136, 0.28);
        }

        /* Table Wrapper */
        .table-wrapper {
            width: 100%;
            overflow-x: auto;
        }

        /* Doctor Table */
        .doctor-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 850px;
        }

        .doctor-table th {
            background: #f8fafc;
            color: #64748b;
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 15px 18px;
            text-align: left;
            border-bottom: 1px solid #e2e8f0;
        }

        .doctor-table td {
            padding: 17px 18px;
            color: #475569;
            font-size: 14px;
            border-bottom: 1px solid #f1f5f9;
            vertical-align: middle;
        }

        .doctor-table tbody tr {
            transition: background 0.2s ease;
        }

        .doctor-table tbody tr:hover {
            background: #f8fcfc;
        }

        .doctor-table tbody tr:last-child td {
            border-bottom: none;
        }

        /* Doctor ID */
        .doctor-id {
            color: #64748b;
            font-weight: 600;
        }

        /* Doctor Name */
        .doctor-name {
            color: #1e293b;
            font-weight: 650;
        }

        /* Specialization */
        .specialization-badge {
            display: inline-block;
            background: #eff6ff;
            color: #2563eb;
            padding: 6px 11px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        /* Phone */
        .phone-text {
            color: #475569;
            white-space: nowrap;
        }

        /* Email */
        .email-text {
            color: #475569;
        }

        /* Actions */
        .action-buttons {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .action-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 7px 12px;
            border-radius: 7px;
            text-decoration: none;
            font-size: 12px;
            font-weight: 600;
            transition: all 0.2s ease;
        }

        .edit-btn {
            background: #ecfeff;
            color: #0f766e !important;
            border: 1px solid #ccfbf1;
        }

        .edit-btn:hover {
            background: #ccfbf1;
            transform: translateY(-1px);
        }

        .delete-btn {
            background: #fff1f2;
            color: #dc2626 !important;
            border: 1px solid #ffe4e6;
        }

        .delete-btn:hover {
            background: #ffe4e6;
            transform: translateY(-1px);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 55px 20px;
            color: #64748b;
        }

        .empty-icon {
            font-size: 42px;
            margin-bottom: 12px;
        }

        .empty-state h3 {
            margin: 0 0 6px;
            color: #334155;
        }

        .empty-state p {
            margin: 0;
            font-size: 14px;
        }

        /* Responsive */
        @media (max-width: 768px) {

            .doctors-container {
                padding: 25px 15px;
            }

            .page-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .page-heading h1 {
                font-size: 24px;
            }

            .table-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .add-doctor-btn {
                width: 100%;
                justify-content: center;
            }

            .doctor-count {
                display: none;
            }
        }
    </style>
</head>

<body>

    <!-- Navbar -->
    <div class="navbar">
        <h2>Hospital Management System</h2>

        <div>
            <a href="dashboard.jsp">Dashboard</a>
            <a href="logout">Logout</a>
        </div>
    </div>


    <!-- Doctors Page -->
    <div class="doctors-container">

        <!-- Page Heading -->
        <div class="page-header">

            <div class="page-heading">

                <div class="page-icon">
                    👨‍⚕️
                </div>

                <div>
                    <h1>Doctors</h1>
                    <p>Manage and view all registered doctors</p>
                </div>

            </div>

            <div class="doctor-count">
                <%= doctorCount %> Registered Doctors
            </div>

        </div>


        <!-- Doctors Card -->
        <div class="doctors-card">

            <!-- Table Header -->
            <div class="table-header">

                <div>
                    <h3>Doctor Records</h3>
                    <p>View, edit or remove doctor information</p>
                </div>

                <a class="add-doctor-btn" href="doctor?action=add">
                    + Add Doctor
                </a>

            </div>


            <!-- Table -->
            <div class="table-wrapper">

                <table class="doctor-table">

                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Specialization</th>
                            <th>Phone</th>
                            <th>Email</th>
                            <th>Actions</th>
                        </tr>
                    </thead>

                    <tbody>

                    <%
                        if (doctors != null && !doctors.isEmpty()) {

                            for (Doctor d : doctors) {
                    %>

                        <tr>

                            <td>
                                <span class="doctor-id">
                                    #<%= d.getId() %>
                                </span>
                            </td>

                            <td>
                                <span class="doctor-name">
                                    <%= d.getName() %>
                                </span>
                            </td>

                            <td>
                                <span class="specialization-badge">
                                    <%= d.getSpecialization() %>
                                </span>
                            </td>

                            <td>
                                <span class="phone-text">
                                    <%= d.getPhone() %>
                                </span>
                            </td>

                            <td>
                                <span class="email-text">
                                    <%= d.getEmail() %>
                                </span>
                            </td>

                            <td>

                                <div class="action-buttons">

                                    <a class="action-btn edit-btn"
                                       href="doctor?action=edit&id=<%= d.getId() %>">
                                        Edit
                                    </a>

                                    <a class="action-btn delete-btn"
                                       href="doctor?action=delete&id=<%= d.getId() %>"
                                       onclick="return confirm('Delete this doctor?');">
                                        Delete
                                    </a>

                                </div>

                            </td>

                        </tr>

                    <%
                            }

                        } else {
                    %>

                        <tr>
                            <td colspan="6">

                                <div class="empty-state">

                                    <div class="empty-icon">
                                        👨‍⚕️
                                    </div>

                                    <h3>No Doctors Found</h3>

                                    <p>
                                        No doctor records are currently available.
                                    </p>

                                </div>

                            </td>
                        </tr>

                    <%
                        }
                    %>

                    </tbody>

                </table>

            </div>

        </div>

    </div>

</body>
</html>
 
 