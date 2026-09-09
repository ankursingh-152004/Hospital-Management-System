<%-- <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.hms.model.Patient, com.hms.model.Doctor" %>
<% if (session.getAttribute("adminUser") == null) { response.sendRedirect("login.jsp"); return; } %>
<!DOCTYPE html>
<html>
<head>
  <title>New Appointment</title>
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
      <h3>Book Appointment</h3>
      <form action="appointment" method="post">
        <input type="hidden" name="action" value="insert">
        <label>Patient</label>
        <select name="patientId" required>
          <%
            List<Patient> patients = (List<Patient>) request.getAttribute("patients");
            if (patients != null) for (Patient p : patients) {
          %>
          <option value="<%= p.getId() %>"><%= p.getName() %></option>
          <% } %>
        </select>
        <label>Doctor</label>
        <select name="doctorId" required>
          <%
            List<Doctor> doctors = (List<Doctor>) request.getAttribute("doctors");
            if (doctors != null) for (Doctor d : doctors) {
          %>
          <option value="<%= d.getId() %>"><%= d.getName() %> (<%= d.getSpecialization() %>)</option>
          <% } %>
        </select>
        <label>Date</label>
        <input type="date" name="appointmentDate" required>
        <button type="submit">Book</button>
        <a class="btn btn-danger" href="appointment?action=list">Cancel</a>
      </form>
    </div>
  </div>
</body>
</html>
 --%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.hms.model.Patient, com.hms.model.Doctor" %>

<%
    if (session.getAttribute("adminUser") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
@SuppressWarnings("unchecked")
    List<Patient> patients =
        (List<Patient>) request.getAttribute("patients");
@SuppressWarnings("unchecked")
    List<Doctor> doctors =
        (List<Doctor>) request.getAttribute("doctors");
%>

<!DOCTYPE html>
<html>

<head>

    <title>New Appointment | Hospital Management System</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <style>

        /* =====================================
           NEW APPOINTMENT PAGE
           ===================================== */

        .appointment-form-container {
            max-width: 950px;
            margin: 0 auto;
            padding: 35px 25px;
        }

        /* Page Header */
        .form-page-header {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 28px;
        }

        .form-page-icon {
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

        .form-page-header h1 {
            margin: 0;
            color: #123047;
            font-size: 28px;
            font-weight: 700;
        }

        .form-page-header p {
            margin: 5px 0 0;
            color: #718096;
            font-size: 14px;
        }

        /* Main Card */
        .appointment-form-card {
            background: #ffffff;
            border: 1px solid #e6edf2;
            border-radius: 18px;
            box-shadow: 0 8px 30px rgba(15, 23, 42, 0.06);
            overflow: hidden;
        }

        /* Card Header */
        .appointment-card-header {
            padding: 23px 28px;
            border-bottom: 1px solid #edf2f7;
            background: #fbfefe;
        }

        .appointment-card-header h3 {
            margin: 0;
            color: #1e293b;
            font-size: 18px;
        }

        .appointment-card-header p {
            margin: 5px 0 0;
            color: #94a3b8;
            font-size: 13px;
        }

        /* Form */
        .appointment-form {
            padding: 30px 28px;
        }

        .appointment-form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 23px 24px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
        }

        .form-group label {
            margin-bottom: 8px;
            color: #334155;
            font-size: 13px;
            font-weight: 650;
        }

        .required-mark {
            color: #dc2626;
            margin-left: 3px;
        }

        /* Select & Date Input */
        .appointment-form select,
        .appointment-form input[type="date"] {
            width: 100%;
            box-sizing: border-box;
            padding: 12px 14px;
            border: 1px solid #d9e2e8;
            border-radius: 9px;
            background: #ffffff;
            color: #1e293b;
            font-size: 14px;
            outline: none;
            transition: all 0.2s ease;
            cursor: pointer;
        }

        .appointment-form select:hover,
        .appointment-form input[type="date"]:hover {
            border-color: #b8c7d1;
        }

        .appointment-form select:focus,
        .appointment-form input[type="date"]:focus {
            border-color: #0d9488;
            box-shadow: 0 0 0 3px rgba(13, 148, 136, 0.10);
        }

        /* Information Box */
        .appointment-info {
            grid-column: 1 / -1;
            display: flex;
            align-items: flex-start;
            gap: 12px;
            padding: 15px 17px;
            border-radius: 10px;
            background: #f0fdfa;
            border: 1px solid #ccfbf1;
            color: #475569;
            font-size: 13px;
            line-height: 1.5;
        }

        .appointment-info-icon {
            font-size: 18px;
            flex-shrink: 0;
        }

        /* Form Actions */
        .appointment-form-actions {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-top: 30px;
            padding-top: 23px;
            border-top: 1px solid #edf2f7;
        }

        .book-appointment-btn {
            border: none;
            padding: 11px 24px;
            border-radius: 9px;
            background: linear-gradient(135deg, #0f766e, #0d9488);
            color: #ffffff;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            box-shadow: 0 5px 14px rgba(13, 148, 136, 0.20);
            transition: all 0.2s ease;
        }

        .book-appointment-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 18px rgba(13, 148, 136, 0.28);
        }

        .cancel-appointment-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 10px 22px;
            border-radius: 9px;
            background: #f8fafc;
            color: #475569 !important;
            border: 1px solid #e2e8f0;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.2s ease;
        }

        .cancel-appointment-btn:hover {
            background: #f1f5f9;
            border-color: #cbd5e1;
        }

        /* Empty Option State */
        .empty-option {
            color: #94a3b8;
        }

        /* Responsive */
        @media (max-width: 700px) {

            .appointment-form-container {
                padding: 25px 15px;
            }

            .form-page-header h1 {
                font-size: 23px;
            }

            .appointment-form {
                padding: 25px 20px;
            }

            .appointment-form-grid {
                grid-template-columns: 1fr;
                gap: 18px;
            }

            .form-group.full-width,
            .appointment-info {
                grid-column: auto;
            }

            .appointment-form-actions {
                flex-direction: column;
                align-items: stretch;
            }

            .book-appointment-btn,
            .cancel-appointment-btn {
                width: 100%;
                box-sizing: border-box;
                text-align: center;
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


    <!-- Appointment Form -->
    <div class="appointment-form-container">

        <!-- Page Header -->
        <div class="form-page-header">

            <div class="form-page-icon">
                📅
            </div>

            <div>

                <h1>New Appointment</h1>

                <p>
                    Schedule an appointment between a patient and doctor
                </p>

            </div>

        </div>


        <!-- Form Card -->
        <div class="appointment-form-card">

            <!-- Card Header -->
            <div class="appointment-card-header">

                <h3>Appointment Details</h3>

                <p>
                    Select the patient, doctor and preferred appointment date.
                </p>

            </div>


            <!-- Form -->
            <form class="appointment-form"
                  action="appointment"
                  method="post">

                <!-- Hidden Action -->
                <input type="hidden"
                       name="action"
                       value="insert">


                <div class="appointment-form-grid">

                    <!-- Patient -->
                    <div class="form-group">

                        <label>
                            Patient
                            <span class="required-mark">*</span>
                        </label>

                        <select name="patientId" required>

                            <option value="" disabled selected>
                                Select a patient
                            </option>

                            <%
                                if (patients != null) {
                                    for (Patient p : patients) {
                            %>

                                <option value="<%= p.getId() %>">
                                    <%= p.getName() %>
                                </option>

                            <%
                                    }
                                }
                            %>

                        </select>

                    </div>


                    <!-- Doctor -->
                    <div class="form-group">

                        <label>
                            Doctor
                            <span class="required-mark">*</span>
                        </label>

                        <select name="doctorId" required>

                            <option value="" disabled selected>
                                Select a doctor
                            </option>

                            <%
                                if (doctors != null) {
                                    for (Doctor d : doctors) {
                            %>

                                <option value="<%= d.getId() %>">
                                    <%= d.getName() %>
                                    (<%= d.getSpecialization() %>)
                                </option>

                            <%
                                    }
                                }
                            %>

                        </select>

                    </div>


                    <!-- Appointment Date -->
                    <div class="form-group">

                        <label>
                            Appointment Date
                            <span class="required-mark">*</span>
                        </label>

                        <input type="date"
                               name="appointmentDate"
                               required>

                    </div>


                    <!-- Information -->
                    <div class="appointment-info">

                        <div class="appointment-info-icon">
                            ℹ️
                        </div>

                        <div>
                            Please verify the patient and doctor details
                            before booking the appointment.
                        </div>

                    </div>

                </div>


                <!-- Form Actions -->
                <div class="appointment-form-actions">

                    <button type="submit"
                            class="book-appointment-btn">

                        📅 Book Appointment

                    </button>

                    <a class="cancel-appointment-btn"
                       href="appointment?action=list">

                        Cancel

                    </a>

                </div>

            </form>

        </div>

    </div>

</body>

</html>
 
 