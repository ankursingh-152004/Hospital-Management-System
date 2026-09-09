<%-- <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.hms.model.Doctor" %>
<% if (session.getAttribute("adminUser") == null) { response.sendRedirect("login.jsp  "); return; } %>
<%
  Doctor d = (Doctor) request.getAttribute("doctor");
  boolean isEdit = (d != null);
%>
<!DOCTYPE html>
<html>
<head>
  <title><%= isEdit ? "Edit" : "Add" %> Doctor</title>
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
      <h3><%= isEdit ? "Edit" : "Add" %> Doctor</h3>
      <form action="doctor" method="post">
        <input type="hidden" name="action" value="<%= isEdit ? "update" : "insert" %>">
        <% if (isEdit) { %><input type="hidden" name="id" value="<%= d.getId() %>"><% } %>
        <label>Name</label>
        <input type="text" name="name" value="<%= isEdit ? d.getName() : "" %>" required>
        <label>Specialization</label>
        <input type="text" name="specialization" value="<%= isEdit ? d.getSpecialization() : "" %>">
        <label>Phone</label>
        <input type="text" name="phone" value="<%= isEdit ? d.getPhone() : "" %>">
        <label>Email</label>
        <input type="text" name="email" value="<%= isEdit ? d.getEmail() : "" %>">
        <button type="submit">Save</button>
        <a class="btn btn-danger" href="doctor?action=list">Cancel</a>
      </form>
    </div>
  </div>
</body>
</html>
 --%>
    
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.hms.model.Doctor" %>

<%
    if (session.getAttribute("adminUser") == null) {
        response.sendRedirect("login.  ");
        return;
    }

    Doctor d = (Doctor) request.getAttribute("doctor");
    boolean isEdit = (d != null);
%>

<!DOCTYPE html>
<html>
<head>

    <title><%= isEdit ? "Edit" : "Add" %> Doctor | Hospital Management System</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <style>

        /* =====================================
           ADD / EDIT DOCTOR PAGE
           ===================================== */

        .doctor-form-container {
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

        /* Form Card */
        .doctor-form-card {
            background: #ffffff;
            border: 1px solid #e6edf2;
            border-radius: 18px;
            box-shadow: 0 8px 30px rgba(15, 23, 42, 0.06);
            overflow: hidden;
        }

        /* Card Header */
        .doctor-form-card-header {
            padding: 23px 28px;
            border-bottom: 1px solid #edf2f7;
            background: #fbfefe;
        }

        .doctor-form-card-header h3 {
            margin: 0;
            color: #1e293b;
            font-size: 18px;
        }

        .doctor-form-card-header p {
            margin: 5px 0 0;
            color: #94a3b8;
            font-size: 13px;
        }

        /* Form */
        .doctor-form {
            padding: 30px 28px;
        }

        .doctor-form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 22px 24px;
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

        /* Inputs */
        .doctor-form input {
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
        }

        .doctor-form input::placeholder {
            color: #a0aec0;
        }

        .doctor-form input:hover {
            border-color: #b8c7d1;
        }

        .doctor-form input:focus {
            border-color: #0d9488;
            box-shadow: 0 0 0 3px rgba(13, 148, 136, 0.10);
        }

        /* Field Icon-like Prefix */
        .input-description {
            margin-top: 6px;
            color: #94a3b8;
            font-size: 11px;
        }

        /* Form Actions */
        .doctor-form-actions {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-top: 30px;
            padding-top: 23px;
            border-top: 1px solid #edf2f7;
        }

        .save-doctor-btn {
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

        .save-doctor-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 18px rgba(13, 148, 136, 0.28);
        }

        .cancel-doctor-btn {
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

        .cancel-doctor-btn:hover {
            background: #f1f5f9;
            border-color: #cbd5e1;
        }

        /* Edit Mode */
        .edit-mode {
            background: #eff6ff;
            color: #2563eb;
            padding: 6px 11px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 700;
            margin-left: 8px;
        }

        .add-mode {
            background: #ecfdf5;
            color: #047857;
            padding: 6px 11px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 700;
            margin-left: 8px;
        }

        /* Responsive */
        @media (max-width: 700px) {

            .doctor-form-container {
                padding: 25px 15px;
            }

            .form-page-header h1 {
                font-size: 23px;
            }

            .doctor-form {
                padding: 25px 20px;
            }

            .doctor-form-grid {
                grid-template-columns: 1fr;
                gap: 18px;
            }

            .form-group.full-width {
                grid-column: auto;
            }

            .doctor-form-actions {
                flex-direction: column;
                align-items: stretch;
            }

            .save-doctor-btn,
            .cancel-doctor-btn {
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
            <a href="dashboard.  ">Dashboard</a>
            <a href="logout">Logout</a>
        </div>

    </div>


    <!-- Doctor Form Page -->
    <div class="doctor-form-container">

        <!-- Page Header -->
        <div class="form-page-header">

            <div class="form-page-icon">
                👨‍⚕️
            </div>

            <div>
                <h1>
                    <%= isEdit ? "Edit Doctor" : "Add New Doctor" %>

                    <% if (isEdit) { %>
                        <span class="edit-mode">EDIT MODE</span>
                    <% } else { %>
                        <span class="add-mode">NEW DOCTOR</span>
                    <% } %>
                </h1>

                <p>
                    <%= isEdit
                        ? "Update the doctor's information below"
                        : "Enter the doctor's information to add them to the system" %>
                </p>
            </div>

        </div>


        <!-- Form Card -->
        <div class="doctor-form-card">

            <div class="doctor-form-card-header">

                <h3>Doctor Information</h3>

                <p>
                    Please provide accurate information for the doctor record.
                </p>

            </div>


            <!-- Doctor Form -->
            <form class="doctor-form" action="doctor" method="post">

                <!-- Hidden Action -->
                <input
                    type="hidden"
                    name="action"
                    value="<%= isEdit ? "update" : "insert" %>">


                <!-- Hidden ID for Edit -->
                <% if (isEdit) { %>

                    <input
                        type="hidden"
                        name="id"
                        value="<%= d.getId() %>">

                <% } %>


                <div class="doctor-form-grid">

                    <!-- Name -->
                    <div class="form-group">

                        <label>
                            Doctor Name
                            <span class="required-mark">*</span>
                        </label>

                        <input
                            type="text"
                            name="name"
                            value="<%= isEdit ? d.getName() : "" %>"
                            placeholder="Enter doctor's full name"
                            autocomplete="name"
                            required>

                    </div>


                    <!-- Specialization -->
                    <div class="form-group">

                        <label>
                            Specialization
                        </label>

                        <input
                            type="text"
                            name="specialization"
                            value="<%= isEdit ? d.getSpecialization() : "" %>"
                            placeholder="e.g. Cardiologist, Dentist"
                            autocomplete="off">

                        <span class="input-description">
                            Doctor's medical specialization
                        </span>

                    </div>


                    <!-- Phone -->
                    <div class="form-group">

                        <label>
                            Phone Number
                        </label>

                        <input
                            type="text"
                            name="phone"
                            value="<%= isEdit ? d.getPhone() : "" %>"
                            placeholder="Enter phone number"
                            autocomplete="tel">

                    </div>


                    <!-- Email -->
                    <div class="form-group">

                        <label>
                            Email Address
                        </label>

                        <input
                            type="text"
                            name="email"
                            value="<%= isEdit ? d.getEmail() : "" %>"
                            placeholder="doctor@example.com"
                            autocomplete="email">

                    </div>

                </div>


                <!-- Form Actions -->
                <div class="doctor-form-actions">

                    <button
                        type="submit"
                        class="save-doctor-btn">

                        <%= isEdit ? "Update Doctor" : "Save Doctor" %>

                    </button>

                    <a
                        class="cancel-doctor-btn"
                        href="doctor?action=list">

                        Cancel

                    </a>

                </div>

            </form>

        </div>

    </div>

</body>
</html>
 
 