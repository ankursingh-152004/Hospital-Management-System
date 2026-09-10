<%-- <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Hospital Management System - Login</title>
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
  <div class="login-wrapper">
    <div class="login-box">
      <h2>HMS Login</h2>
      <form action="login" method="post">
        <label>Username</label>
        <input type="text" name="username" required>
        <label>Password</label>
        <input type="password" name="password" required>
        <button type="submit" style="width:100%;">Login</button>
        <% if ("1".equals(request.getParameter("error"))) { %>
          <div class="error">Invalid username or password.</div>
        <% } %>
      </form>
    </div>
  </div>
</body>
</html>
 --%>
 <%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>

<html>

<head>


<title>Hospital Management System - Login</title>

<link rel="stylesheet" href="css/style.css">

<style>

    /* =====================================
       LOGIN PAGE
    ===================================== */

    .login-wrapper {

        min-height: 100vh;

        display: flex;

        align-items: center;

        justify-content: center;

        padding: 20px;

        background:
            linear-gradient(
                135deg,
                #eaf7f8 0%,
                #f5f9fc 50%,
                #e8f2fa 100%
            );

        position: relative;

        overflow: hidden;
    }


    /* Decorative background circles */

    .login-wrapper::before {

        content: "";

        position: absolute;

        width: 400px;

        height: 400px;

        border-radius: 50%;

        background: rgba(8, 127, 140, 0.06);

        top: -180px;

        left: -150px;
    }

    .login-wrapper::after {

        content: "";

        position: absolute;

        width: 450px;

        height: 450px;

        border-radius: 50%;

        background: rgba(23, 105, 170, 0.05);

        bottom: -220px;

        right: -170px;
    }


    /* =====================================
       LOGIN CARD
    ===================================== */

    .login-box {

        width: 410px;

        max-width: 100%;

        background: #ffffff;

        border-radius: 18px;

        padding: 38px 40px;

        border: 1px solid #e3edf1;

        box-shadow:
            0 15px 45px rgba(22, 50, 79, 0.12);

        position: relative;

        z-index: 2;
    }


    /* =====================================
       HOSPITAL ICON
    ===================================== */

    .login-icon {

        width: 68px;

        height: 68px;

        margin: 0 auto 18px;

        border-radius: 16px;

        display: flex;

        align-items: center;

        justify-content: center;

        background: linear-gradient(
            135deg,
            #087f8c,
            #0b9aa7
        );

        color: #ffffff;

        font-size: 32px;

        box-shadow:
            0 7px 18px rgba(8, 127, 140, 0.20);
    }


    /* =====================================
       TITLE
    ===================================== */

    .login-box h2 {

        text-align: center;

        color: #16324f;

        font-size: 25px;

        font-weight: 650;

        margin: 0;
    }

    .login-subtitle {

        text-align: center;

        color: #7b8794;

        font-size: 13px;

        margin: 6px 0 28px;
    }


    /* =====================================
       FORM
    ===================================== */

    .login-form label {

        display: block;

        margin: 16px 0 7px;

        color: #334155;

        font-size: 13px;

        font-weight: 600;
    }


    .login-input {

        width: 100%;

        padding: 12px 14px;

        border: 1px solid #d9e3e9;

        border-radius: 8px;

        background: #fbfdfe;

        color: #263b4d;

        font-size: 14px;

        outline: none;

        transition: all 0.25s ease;
    }

    .login-input::placeholder {

        color: #a0acb7;
    }

    .login-input:focus {

        background: #ffffff;

        border-color: #0b9aa7;

        box-shadow:
            0 0 0 3px rgba(11, 154, 167, 0.10);
    }


    /* =====================================
       LOGIN BUTTON
    ===================================== */

    .login-button {

        width: 100%;

        margin-top: 25px !important;

        padding: 12px !important;

        border: none;

        border-radius: 8px !important;

        background: linear-gradient(
            135deg,
            #087f8c,
            #0b9aa7
        ) !important;

        color: #ffffff;

        font-size: 14px;

        font-weight: 600;

        cursor: pointer;

        box-shadow:
            0 5px 14px rgba(8, 127, 140, 0.20);

        transition: all 0.25s ease;
    }

    .login-button:hover {

        background: linear-gradient(
            135deg,
            #066b76,
            #087f8c
        ) !important;

        transform: translateY(-2px);

        box-shadow:
            0 8px 18px rgba(8, 127, 140, 0.25);
    }


    /* =====================================
       ERROR MESSAGE
    ===================================== */

    .login-error {

        margin-top: 15px;

        padding: 10px 12px;

        border-radius: 7px;

        background: #fff2f2;

        border: 1px solid #ffd5d5;

        color: #d64545;

        font-size: 13px;

        text-align: center;
    }


    /* =====================================
       FOOTER
    ===================================== */

    .login-footer {

        text-align: center;

        margin-top: 25px;

        padding-top: 18px;

        border-top: 1px solid #edf1f4;

        color: #9aa6b2;

        font-size: 11px;
    }

    .login-footer strong {

        color: #087f8c;
    }


    /* =====================================
       RESPONSIVE
    ===================================== */

    @media (max-width: 480px) {

        .login-box {

            padding: 30px 25px;

            border-radius: 14px;
        }

        .login-box h2 {

            font-size: 22px;
        }

        .login-icon {

            width: 60px;

            height: 60px;

            font-size: 28px;
        }

    }

</style>


</head>

<body>


<div class="login-wrapper">

    <div class="login-box">


        <!-- HOSPITAL ICON -->

        <div class="login-icon">
            🏥
        </div>


        <!-- TITLE -->

        <h2>
            HMS Login
        </h2>

        <p class="login-subtitle">
            Hospital Management System
        </p>


        <!-- LOGIN FORM -->

        <form
            class="login-form"
            action="login"
            method="post"
        >


            <!-- USERNAME -->

            <label>
                Username
            </label>

            <input
                class="login-input"
                type="text"
                name="username"
                placeholder="Enter your username"
                autocomplete="username"
                required
            >


            <!-- PASSWORD -->

            <label>
                Password
            </label>

            <input
                class="login-input"
                type="password"
                name="password"
                placeholder="Enter your password"
                autocomplete="current-password"
                required
            >


            <!-- LOGIN -->

            <button
                type="submit"
                class="login-button"
            >
                Login to Dashboard →
            </button>


            <!-- ERROR -->

            <% if ("1".equals(request.getParameter("error"))) { %>

                <div class="login-error">

                    ⚠ Invalid username or password.

                </div>

            <% } %>


        </form>


        <!-- FOOTER -->

        <div class="login-footer">

            <strong>HMS</strong> · Secure Hospital Administration<br>
            For Testing : 
            Username: Ankur <br>
                Password: 123

        </div>


    </div>

</div>


</body>

</html>
 