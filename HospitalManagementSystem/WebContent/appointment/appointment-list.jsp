<%-- <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.hms.model.Appointment" %>
<% if (session.getAttribute("adminUser") == null) { response.sendRedirect("../login.jsp  "); return; } %>
<!DOCTYPE html>
<html>
<head>
  <title>Appointments</title>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
  <div class="navbar">
    <h2>Hospital Management System</h2>
    <div>
      <a href="dashboard.  ">Dashboard</a>
      <a href="logout">Logout</a>
    </div>
  </div>
  <div class="container">
    <div class="card">
      <div class="top-actions">
        <a class="btn" href="appointment?action=add">+ New Appointment</a>
      </div>
      <table>
        <tr><th>ID</th><th>Patient</th><th>Doctor</th><th>Date</th><th>Status</th><th>Actions</th></tr>
        <%
          List<Appointment> appts = (List<Appointment>) request.getAttribute("appointments");
          if (appts != null) {
            for (Appointment a : appts) {
        %>
        <tr>
          <td><%= a.getId() %></td>
          <td><%= a.getPatientName() %></td>
          <td><%= a.getDoctorName() %></td>
          <td><%= a.getAppointmentDate() %></td>
          <td><%= a.getStatus() %></td>
          <td>
            <a href="appointment?action=delete&id=<%= a.getId() %>" onclick="return confirm('Cancel this appointment?');">Delete</a>
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
<%@ page import="java.util.*, com.hms.model.Appointment" %>

<%
    if (session.getAttribute("adminUser") == null) {
        response.sendRedirect("../login.  ");
        return;
    }
@SuppressWarnings("unchecked")
    List<Appointment> appts =
        (List<Appointment>) request.getAttribute("appointments");

    int appointmentCount = appts != null ? appts.size() : 0;
%>

<!DOCTYPE html>
<html>

<head>

    <title>Appointments | Hospital Management System</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <style>

        /* =====================================
           APPOINTMENTS PAGE
           ===================================== */

        .appointments-container {
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

        /* Appointment Count */
        .appointment-count {
            background: #ecfdf5;
            color: #047857;
            padding: 8px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
            white-space: nowrap;
        }

        /* Main Card */
        .appointments-card {
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
            gap: 15px;
            padding: 22px 25px;
            border-bottom: 1px solid #edf2f7;
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

        /* New Appointment Button */
        .new-appointment-btn {
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

        .new-appointment-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 18px rgba(13, 148, 136, 0.28);
        }

        /* Table Wrapper */
        .table-wrapper {
            width: 100%;
            overflow-x: auto;
        }

        /* Appointment Table */
        .appointment-table {
            width: 100%;
            border-collapse: collapse;
            min-width: 850px;
        }

        .appointment-table th {
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

        .appointment-table td {
            padding: 17px 18px;
            color: #475569;
            font-size: 14px;
            border-bottom: 1px solid #f1f5f9;
            vertical-align: middle;
        }

        .appointment-table tbody tr {
            transition: background 0.2s ease;
        }

        .appointment-table tbody tr:hover {
            background: #f8fcfc;
        }

        .appointment-table tbody tr:last-child td {
            border-bottom: none;
        }

        /* Appointment ID */
        .appointment-id {
            color: #64748b;
            font-weight: 600;
        }

        /* Patient & Doctor */
        .patient-name {
            color: #1e293b;
            font-weight: 650;
        }

        .doctor-name {
            color: #475569;
            font-weight: 550;
        }

        /* Date */
        .appointment-date {
            color: #334155;
            font-weight: 550;
            white-space: nowrap;
        }

        /* Status Badge */
        .status-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            background: #eff6ff;
            color: #2563eb;
            font-size: 12px;
            font-weight: 650;
        }

        /* Delete Button */
        .delete-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 7px 13px;
            border-radius: 7px;
            background: #fff1f2;
            color: #dc2626 !important;
            border: 1px solid #ffe4e6;
            text-decoration: none;
            font-size: 12px;
            font-weight: 600;
            transition: all 0.2s ease;
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

            .appointments-container {
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

            .new-appointment-btn {
                width: 100%;
                justify-content: center;
            }

            .appointment-count {
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
            <a href="dashboard.  ">Dashboard</a>
            <a href="logout">Logout</a>
        </div>

    </div>


    <!-- Appointments Page -->
    <div class="appointments-container">

        <!-- Page Header -->
        <div class="page-header">

            <div class="page-heading">

                <div class="page-icon">
                    📅
                </div>

                <div>

                    <h1>Appointments</h1>

                    <p>
                        Manage and view all patient appointments
                    </p>

                </div>

            </div>

            <div class="appointment-count">
                <%= appointmentCount %> Appointments
            </div>

        </div>


        <!-- Appointments Card -->
        <div class="appointments-card">

            <!-- Card Header -->
            <div class="table-header">

                <div>

                    <h3>Appointment Records</h3>

                    <p>
                        View and manage scheduled appointments
                    </p>

                </div>

                <a class="new-appointment-btn"
                   href="appointment?action=add">

                    + New Appointment

                </a>

            </div>


            <!-- Table -->
            <div class="table-wrapper">

                <table class="appointment-table">

                    <thead>

                        <tr>
                            <th>ID</th>
                            <th>Patient</th>
                            <th>Doctor</th>
                            <th>Date</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>

                    </thead>

                    <tbody>

                    <%
                        if (appts != null && !appts.isEmpty()) {

                            for (Appointment a : appts) {
                    %>

                        <tr>

                            <td>
                                <span class="appointment-id">
                                    #<%= a.getId() %>
                                </span>
                            </td>

                            <td>
                                <span class="patient-name">
                                    <%= a.getPatientName() %>
                                </span>
                            </td>

                            <td>
                                <span class="doctor-name">
                                    <%= a.getDoctorName() %>
                                </span>
                            </td>

                            <td>
                                <span class="appointment-date">
                                    <%= a.getAppointmentDate() %>
                                </span>
                            </td>

                            <td>
                                <span class="status-badge">
                                    <%= a.getStatus() %>
                                </span>
                            </td>

                            <td>

                                <a class="delete-btn"
                                   href="appointment?action=delete&id=<%= a.getId() %>"
                                   onclick="return confirm('Cancel this appointment?');">

                                    Cancel

                                </a>

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
                                        📅
                                    </div>

                                    <h3>No Appointments Found</h3>

                                    <p>
                                        No appointments are currently scheduled.
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
 
 