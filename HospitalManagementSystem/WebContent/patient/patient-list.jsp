<%-- <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.hms.model.Patient" %>
<% if (session.getAttribute("adminUser") == null) { response.sendRedirect("login.jsp"); return; } %>
<!DOCTYPE html>
<html>
<head>
  <title>Patients</title>
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
        <a class="btn" href="patient?action=add">+ Add Patient</a>
      </div>
      <table>
        <tr>
          <th>ID</th><th>Name</th><th>Age</th><th>Gender</th><th>Phone</th><th>Address</th><th>Disease</th><th>Actions</th>
        </tr>
        <%
          List<Patient> patients = (List<Patient>) request.getAttribute("patients");
          if (patients != null) {
            for (Patient p : patients) {
        %>
        <tr>
          <td><%= p.getId() %></td>
          <td><%= p.getName() %></td>
          <td><%= p.getAge() %></td>
          <td><%= p.getGender() %></td>
          <td><%= p.getPhone() %></td>
          <td><%= p.getAddress() %></td>
          <td><%= p.getDisease() %></td>
          <td>
            <a class="btn btn-danger" href="patient?action=edit&id=<%= p.getId() %>">Edit</a> |
            <a class="btn btn-danger" href="patient?action=delete&id=<%= p.getId() %>" onclick="return confirm('Delete this patient?');">Delete</a>
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
<%@ page import="java.util.*, com.hms.model.Patient" %>

<%
if (session.getAttribute("adminUser") == null) {
response.sendRedirect("login.jsp");
return;
}
%>

<!DOCTYPE html>

<html>

<head>

  
<title>Patients | Hospital Management System</title>

<link rel="stylesheet" href="css/style.css">

<style>

    /* =========================
       PATIENT PAGE
    ========================= */

    .page-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 25px;
        gap: 20px;
        flex-wrap: wrap;
    }

    .page-title {
        display: flex;
        align-items: center;
        gap: 15px;
    }

    .page-icon {
        width: 52px;
        height: 52px;
        border-radius: 12px;
        background: #e8f5f7;
        color: #087f8c;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 25px;
    }

    .page-title h1 {
        margin: 0;
        font-size: 26px;
        color: #16324f;
        font-weight: 650;
    }

    .page-title p {
        margin: 3px 0 0;
        color: #718096;
        font-size: 14px;
    }

    .patient-count {
        background: #ffffff;
        border: 1px solid #e4edf2;
        border-radius: 10px;
        padding: 10px 18px;
        color: #526477;
        font-size: 14px;
        box-shadow: 0 3px 12px rgba(22, 50, 79, 0.05);
    }

    .patient-count strong {
        color: #087f8c;
        font-size: 18px;
        margin-right: 5px;
    }

    .patients-card {
        padding: 0;
        overflow: hidden;
    }

    .table-header {
        padding: 20px 25px;
        border-bottom: 1px solid #e8eef2;
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 15px;
    }

    .table-header h3 {
        margin: 0;
        color: #16324f;
        font-size: 18px;
    }

    .table-header span {
        color: #7b8794;
        font-size: 13px;
    }

    .table-wrapper {
        width: 100%;
        overflow-x: auto;
    }

    .patient-table {
        width: 100%;
        border-collapse: collapse;
        margin: 0;
        box-shadow: none;
        border-radius: 0;
    }

    .patient-table th {
        background: #f4f8fa;
        color: #526477;
        padding: 14px 16px;
        border-bottom: 1px solid #dfe8ed;
        font-size: 12px;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        white-space: nowrap;
    }

    .patient-table td {
        padding: 15px 16px;
        border-bottom: 1px solid #edf2f5;
        color: #475569;
        font-size: 14px;
        vertical-align: middle;
    }

    .patient-table tr:hover td {
        background: #f8fcfd;
    }

    .patient-table tr:last-child td {
        border-bottom: none;
    }

    .patient-id {
        font-weight: 600;
        color: #087f8c !important;
    }

    .patient-name {
        font-weight: 600;
        color: #16324f !important;
    }

    .gender-badge {
        display: inline-block;
        padding: 4px 10px;
        border-radius: 20px;
        background: #eef5ff;
        color: #3867a8;
        font-size: 12px;
        font-weight: 600;
    }

    .disease-badge {
        display: inline-block;
        padding: 5px 10px;
        border-radius: 6px;
        background: #fff5ed;
        color: #c56a27;
        font-size: 12px;
        font-weight: 600;
    }

    .action-buttons {
        display: flex;
        gap: 7px;
        align-items: center;
    }

    .action-btn {
        padding: 7px 12px !important;
        margin: 0 !important;
        border-radius: 6px !important;
        font-size: 12px !important;
        font-weight: 600;
        box-shadow: none !important;
    }

    .edit-btn {
        background: #e8f5f7 !important;
        color: #087f8c !important;
    }

    .edit-btn:hover {
        background: #d5eef1 !important;
        transform: translateY(-1px);
    }

    .delete-btn {
        background: #fff0f0 !important;
        color: #d64545 !important;
    }

    .delete-btn:hover {
        background: #ffe0e0 !important;
        transform: translateY(-1px);
    }

    .add-patient-btn {
        background: linear-gradient(135deg, #087f8c, #0b9aa7) !important;
        padding: 11px 18px !important;
        border-radius: 8px !important;
        font-weight: 600;
    }

    .add-patient-btn:hover {
        background: linear-gradient(135deg, #066b76, #087f8c) !important;
    }

    @media (max-width: 768px) {

        .page-header {
            align-items: flex-start;
        }

        .page-title h1 {
            font-size: 22px;
        }

        .table-header {
            padding: 16px;
        }

        .patient-table th,
        .patient-table td {
            padding: 12px;
        }

    }

</style>
 

</head>

<body>

  
<!-- =========================
     NAVBAR
========================== -->

<div class="navbar">

    <h2>🏥 Hospital Management System</h2>

    <div>
        <a href="dashboard.jsp">Dashboard</a>
        <a href="logout">Logout</a>
    </div>

</div>


<!-- =========================
     MAIN CONTENT
========================== -->

<div class="container">

    <!-- PAGE HEADER -->

    <div class="page-header">

        <div class="page-title">

            <div class="page-icon">
                👤
            </div>

            <div>
                <h1>Patients</h1>
                <p>Manage and view registered patients</p>
            </div>

        </div>

        <div class="patient-count">

            <%
            @SuppressWarnings("unchecked")
                List<Patient> patients =
                    (List<Patient>) request.getAttribute("patients");

                int patientCount = patients != null ? patients.size() : 0;
            %>

            <strong><%= patientCount %></strong>
            Registered Patients

        </div>

    </div>


    <!-- PATIENT CARD -->

    <div class="card patients-card">

        <!-- TABLE HEADER -->

        <div class="table-header">

            <div>
                <h3>Patient Records</h3>
                <span>View and manage patient information</span>
            </div>

            <a class="btn add-patient-btn"
               href="patient?action=add">

                + Add Patient

            </a>

        </div>


        <!-- TABLE -->

        <div class="table-wrapper">

            <table class="patient-table">

                <tr>

                    <th>ID</th>
                    <th>Patient Name</th>
                    <th>Age</th>
                    <th>Gender</th>
                    <th>Phone</th>
                    <th>Address</th>
                    <th>Medical Condition</th>
                    <th>Actions</th>

                </tr>


                <%

                    if (patients != null) {

                        for (Patient p : patients) {

                %>

                <tr>

                    <td class="patient-id">
                        #<%= p.getId() %>
                    </td>

                    <td class="patient-name">
                        <%= p.getName() %>
                    </td>

                    <td>
                        <%= p.getAge() %> yrs
                    </td>

                    <td>
                        <span class="gender-badge">
                            <%= p.getGender() %>
                        </span>
                    </td>

                    <td>
                        <%= p.getPhone() %>
                    </td>

                    <td>
                        <%= p.getAddress() %>
                    </td>

                    <td>
                        <span class="disease-badge">
                            <%= p.getDisease() %>
                        </span>
                    </td>

                    <td>

                        <div class="action-buttons">

                            <a class="btn action-btn edit-btn"
                               href="patient?action=edit&id=<%= p.getId() %>">

                                Edit

                            </a>

                            <a class="btn action-btn delete-btn"
                               href="patient?action=delete&id=<%= p.getId() %>"
                               onclick="return confirm('Delete this patient?');">

                                Delete

                            </a>

                        </div>

                    </td>

                </tr>

                <%

                        }

                    }

                %>

            </table>

        </div>

    </div>

</div>
  

</body>

</html>
 