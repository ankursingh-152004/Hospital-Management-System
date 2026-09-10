<%-- <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% if (session.getAttribute("adminUser") == null) { response.sendRedirect("login.jsp"); return; } %>
<!DOCTYPE html>
<html>
<head>
  <title>Dashboard</title>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
  <div class="navbar">
    <h2>Hospital Management System</h2>
    <div>
      <span>Welcome, <%= session.getAttribute("adminUser") %></span>
      <a href="logout">Logout</a>
    </div>
  </div>
  <div class="container">
    <div class="dashboard-grid">
      <div class="card">
        <h3>Patients</h3>
        <p>Manage patient records</p>
        <a class="btn" href="patient?action=list">Go to Patients</a>
      </div>
      <div class="card">
        <h3>Doctors</h3>
        <p>Manage doctor records</p>
        <a class="btn" href="doctor?action=list">Go to Doctors</a>
      </div>
      <div class="card">
        <h3>Appointments</h3>
        <p>Manage appointments</p>
        <a class="btn" href="appointment?action=list">Go to Appointments</a>
      </div>
    </div>
  </div>
</body>
</html>
 --%>
 <%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
if (session.getAttribute("adminUser") == null) {
response.sendRedirect("login.jsp");
return;
}
%>

<!DOCTYPE html>

<html>

<head>


<title>Dashboard | Hospital Management System</title>

<link rel="stylesheet" href="css/style.css">

<style>

    /* =====================================
       DASHBOARD
    ===================================== */

    .dashboard-container {
        max-width: 1150px;
        margin: 35px auto;
    }

    /* =====================================
       WELCOME SECTION
    ===================================== */

    .welcome-section {
        background: linear-gradient(
            135deg,
            #087f8c,
            #0b9aa7
        );

        border-radius: 16px;

        padding: 30px 35px;

        color: white;

        display: flex;

        justify-content: space-between;

        align-items: center;

        margin-bottom: 30px;

        box-shadow:
            0 8px 25px rgba(8, 127, 140, 0.20);

        position: relative;

        overflow: hidden;
    }

    .welcome-section::after {
        content: "🏥";

        position: absolute;

        right: 40px;

        bottom: -25px;

        font-size: 130px;

        opacity: 0.10;
    }

    .welcome-content {
        position: relative;
        z-index: 1;
    }

    .welcome-content h1 {
        color: #ffffff;

        font-size: 28px;

        margin: 0 0 7px;

        font-weight: 650;
    }

    .welcome-content p {
        color: rgba(255,255,255,0.85);

        margin: 0;

        font-size: 14px;
    }

    .welcome-user {
        background: rgba(255,255,255,0.15);

        padding: 10px 16px;

        border-radius: 8px;

        font-size: 13px;

        backdrop-filter: blur(5px);

        position: relative;

        z-index: 2;
    }

    /* =====================================
       SECTION TITLE
    ===================================== */

    .section-heading {
        margin-bottom: 18px;
    }

    .section-heading h2 {
        margin: 0;

        color: #16324f;

        font-size: 21px;

        font-weight: 650;
    }

    .section-heading p {
        margin: 3px 0 0;

        color: #7b8794;

        font-size: 13px;
    }

    /* =====================================
       DASHBOARD GRID
    ===================================== */

    .hospital-dashboard-grid {

        display: grid;

        grid-template-columns:
            repeat(3, 1fr);

        gap: 22px;
    }

    /* =====================================
       DASHBOARD CARD
    ===================================== */

    .hospital-card {

        background: #ffffff;

        border-radius: 14px;

        padding: 25px;

        border: 1px solid #e5edf1;

        box-shadow:
            0 5px 20px rgba(22, 50, 79, 0.06);

        transition:
            transform 0.25s ease,
            box-shadow 0.25s ease;

        position: relative;

        overflow: hidden;
    }

    .hospital-card::before {

        content: "";

        position: absolute;

        top: 0;
        left: 0;

        width: 100%;

        height: 4px;

        background: linear-gradient(
            90deg,
            #087f8c,
            #0b9aa7
        );
    }

    .hospital-card:hover {

        transform: translateY(-6px);

        box-shadow:
            0 12px 30px rgba(22, 50, 79, 0.11);
    }

    /* =====================================
       CARD ICON
    ===================================== */

    .card-icon {

        width: 55px;

        height: 55px;

        border-radius: 12px;

        display: flex;

        align-items: center;

        justify-content: center;

        font-size: 26px;

        margin-bottom: 18px;

        background: #e8f5f7;

        color: #087f8c;
    }

    /* Different icon backgrounds */

    .doctor-icon {

        background: #eef4ff;

        color: #3b6db3;
    }

    .appointment-icon {

        background: #fff4e8;

        color: #d47a2a;
    }

    /* =====================================
       CARD CONTENT
    ===================================== */

    .hospital-card h3 {

        color: #16324f;

        margin: 0 0 7px;

        font-size: 19px;

        font-weight: 650;
    }

    .hospital-card p {

        color: #7b8794;

        font-size: 13px;

        margin: 0 0 20px;

        line-height: 1.5;
    }

    /* =====================================
       CARD BUTTON
    ===================================== */

    .dashboard-btn {

        width: 100%;

        text-align: center;

        background: #f1f8f9 !important;

        color: #087f8c !important;

        border: 1px solid #d9edef !important;

        padding: 10px 15px !important;

        border-radius: 7px !important;

        font-size: 13px !important;

        font-weight: 600;

        margin: 0 !important;

        box-shadow: none !important;

        transition: all 0.2s ease;
    }

    .dashboard-btn:hover {

        background: #087f8c !important;

        color: #ffffff !important;

        border-color: #087f8c !important;

        transform: translateY(-1px);
    }

    /* =====================================
       NAVBAR WELCOME
    ===================================== */

    .navbar-user {

        display: flex;

        align-items: center;

        gap: 18px;
    }

    .navbar-user span {

        color: rgba(255,255,255,0.9);

        font-size: 13px;
    }

    .navbar-user a {

        margin-left: 0 !important;

        padding: 7px 13px;

        border: 1px solid rgba(255,255,255,0.25);

        border-radius: 6px;

        transition: 0.2s ease;
    }

    .navbar-user a:hover {

        background: rgba(255,255,255,0.12);

        text-decoration: none;
    }

    /* =====================================
       RESPONSIVE
    ===================================== */

    @media (max-width: 850px) {

        .hospital-dashboard-grid {

            grid-template-columns:
                repeat(2, 1fr);
        }

        .dashboard-container {

            margin: 25px 20px;
        }

    }

    @media (max-width: 600px) {

        .hospital-dashboard-grid {

            grid-template-columns: 1fr;
        }

        .welcome-section {

            padding: 25px;

        }

        .welcome-content h1 {

            font-size: 23px;
        }

        .welcome-user {

            display: none;
        }

    }

</style>


</head>

<body>


<!-- =====================================
     NAVBAR
====================================== -->

<div class="navbar">

    <h2>🏥 Hospital Management System</h2>

    <div class="navbar-user">

        <span>
            Welcome,
            <strong>
                <%= session.getAttribute("adminUser") %>
            </strong>
        </span>

        <a href="logout">
            Logout
        </a>

    </div>

</div>


<!-- =====================================
     MAIN DASHBOARD
====================================== -->

<div class="container dashboard-container">


    <!-- WELCOME BANNER -->

    <div class="welcome-section">

        <div class="welcome-content">

            <h1>
                Hospital Dashboard
            </h1>

            <p>
                Manage patients, doctors and appointments from one place.
            </p>

        </div>

        <div class="welcome-user">

            👋 Welcome,
            <strong>
                <%= session.getAttribute("adminUser") %>
            </strong>

        </div>

    </div>


    <!-- SECTION TITLE -->

    <div class="section-heading">

        <h2>
            Hospital Management
        </h2>

        <p>
            Select a module to manage hospital operations
        </p>

    </div>


    <!-- DASHBOARD CARDS -->

    <div class="hospital-dashboard-grid">


        <!-- PATIENTS -->

        <div class="hospital-card">

            <div class="card-icon">

                👤

            </div>

            <h3>
                Patients
            </h3>

            <p>
                Register new patients, update patient
                information and manage medical records.
            </p>

            <a
                class="btn dashboard-btn"
                href="patient?action=list"
            >
                Manage Patients →
            </a>

        </div>


        <!-- DOCTORS -->

        <div class="hospital-card">

            <div class="card-icon doctor-icon">

                🩺

            </div>

            <h3>
                Doctors
            </h3>

            <p>
                Manage doctor profiles, specialties and
                other doctor-related information.
            </p>

            <a
                class="btn dashboard-btn"
                href="doctor?action=list"
            >
                Manage Doctors →
            </a>

        </div>


        <!-- APPOINTMENTS -->

        <div class="hospital-card">

            <div class="card-icon appointment-icon">

                📅

            </div>

            <h3>
                Appointments
            </h3>

            <p>
                Schedule, view and manage patient
                appointments with doctors.
            </p>

            <a
                class="btn dashboard-btn"
                href="appointment?action=list"
            >
                Manage Appointments →
            </a>

        </div>


    </div>


</div>

</body>

</html>
 