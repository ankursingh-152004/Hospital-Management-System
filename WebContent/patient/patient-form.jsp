<%-- <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.hms.model.Patient" %>
<% if (session.getAttribute("adminUser") == null) { response.sendRedirect("login.jsp"); return; } %>
<%
  Patient p = (Patient) request.getAttribute("patient");
  boolean isEdit = (p != null);
%>
<!DOCTYPE html>
<html>
<head>
  <title><%= isEdit ? "Edit" : "Add" %> Patient</title>
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
      <h3><%= isEdit ? "Edit" : "Add" %> Patient</h3>
      <form action="patient" method="post">
        <input type="hidden" name="action" value="<%= isEdit ? "update" : "insert" %>">
        <% if (isEdit) { %><input type="hidden" name="id" value="<%= p.getId() %>"><% } %>
        <label>Name</label>
        <input type="text" name="name" value="<%= isEdit ? p.getName() : "" %>" required>
        <label>Age</label>
        <input type="number" name="age" value="<%= isEdit ? p.getAge() : "" %>" required>
        <label>Gender</label>
        <select name="gender">
          <option <%= isEdit && "Male".equals(p.getGender()) ? "selected" : "" %>>Male</option>
          <option <%= isEdit && "Female".equals(p.getGender()) ? "selected" : "" %>>Female</option>
          <option <%= isEdit && "Other".equals(p.getGender()) ? "selected" : "" %>>Other</option>
        </select>
        <label>Phone</label>
        <input type="text" name="phone" value="<%= isEdit ? p.getPhone() : "" %>">
        <label>Address</label>
        <textarea name="address" rows="2"><%= isEdit ? p.getAddress() : "" %></textarea>
        <label>Disease / Reason</label>
        <input type="text" name="disease" value="<%= isEdit ? p.getDisease() : "" %>">
        <button type="submit">Save</button>
        <a class="btn btn-danger" href="patient?action=list">Cancel</a>
      </form>
    </div>
  </div>
</body>
</html>
 --%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%@ page import="com.hms.model.Patient"%>

<%
if (session.getAttribute("adminUser") == null) {
	response.sendRedirect("login.jsp");
	return;
}
%>

<%
Patient p = (Patient) request.getAttribute("patient");
boolean isEdit = (p != null);
%>

<!DOCTYPE html>

<html>

<head>


<title><%=isEdit ? "Edit" : "Add"%> Patient | Hospital
	Management System</title>

<link rel="stylesheet" href="css/style.css">

<style>

/* ==============================
       PATIENT FORM PAGE
    ============================== */
.form-container {
	max-width: 850px;
	margin: 35px auto;
}

.form-header {
	display: flex;
	align-items: center;
	gap: 15px;
	margin-bottom: 25px;
}

.form-icon {
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

.form-header h1 {
	margin: 0;
	color: #16324f;
	font-size: 26px;
	font-weight: 650;
}

.form-header p {
	margin: 3px 0 0;
	color: #718096;
	font-size: 14px;
}

.form-card {
	background: #ffffff;
	border-radius: 14px;
	box-shadow: 0 8px 30px rgba(22, 50, 79, 0.08);
	border: 1px solid #e5edf1;
	overflow: hidden;
}

.form-card-header {
	padding: 20px 30px;
	border-bottom: 1px solid #e8eef2;
	background: #fbfdfe;
}

.form-card-header h3 {
	margin: 0;
	color: #16324f;
	font-size: 18px;
}

.form-card-header span {
	display: block;
	margin-top: 3px;
	color: #7b8794;
	font-size: 13px;
}

.patient-form {
	padding: 30px;
}

.form-grid {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 20px 25px;
}

.form-group {
	display: flex;
	flex-direction: column;
}

.form-group.full-width {
	grid-column: 1/-1;
}

.form-group label {
	margin: 0 0 7px;
	color: #334155;
	font-size: 13px;
	font-weight: 600;
}

.required {
	color: #dc3545;
}

.input-wrapper {
	position: relative;
}

.input-icon {
	position: absolute;
	left: 12px;
	top: 50%;
	transform: translateY(-50%);
	color: #8aa0b2;
	font-size: 14px;
	pointer-events: none;
}

.patient-form input[type="text"], .patient-form input[type="number"],
	.patient-form select, .patient-form textarea {
	width: 100%;
	padding: 12px 13px;
	border: 1px solid #d9e3e9;
	border-radius: 8px;
	background: #ffffff;
	color: #263b4d;
	font-size: 14px;
	outline: none;
	transition: all 0.25s ease;
}

.patient-form input[type="text"]:focus, .patient-form input[type="number"]:focus,
	.patient-form select:focus, .patient-form textarea:focus {
	border-color: #0b9aa7;
	box-shadow: 0 0 0 3px rgba(11, 154, 167, 0.10);
}

.patient-form textarea {
	resize: vertical;
	min-height: 95px;
}

.helper-text {
	margin-top: 5px;
	color: #8a98a6;
	font-size: 11px;
}

/* ==============================
       FORM ACTIONS
    ============================== */
.form-actions {
	margin-top: 30px;
	padding-top: 22px;
	border-top: 1px solid #e8eef2;
	display: flex;
	justify-content: flex-end;
	gap: 10px;
}

.save-btn {
	background: linear-gradient(135deg, #087f8c, #0b9aa7) !important;
	color: #ffffff !important;
	border: none;
	padding: 11px 23px !important;
	border-radius: 8px !important;
	font-weight: 600;
	margin: 0 !important;
	box-shadow: 0 4px 10px rgba(8, 127, 140, 0.20) !important;
}

.save-btn:hover {
	background: linear-gradient(135deg, #066b76, #087f8c) !important;
	transform: translateY(-1px);
}

.cancel-btn {
	background: #f1f5f8 !important;
	color: #526477 !important;
	border: 1px solid #dce5ea !important;
	padding: 10px 22px !important;
	border-radius: 8px !important;
	font-weight: 600;
	margin: 0 !important;
	box-shadow: none !important;
}

.cancel-btn:hover {
	background: #e7edf1 !important;
	color: #334155 !important;
	transform: translateY(-1px);
}

/* ==============================
       RESPONSIVE
    ============================== */
@media ( max-width : 700px) {
	.form-container {
		margin: 20px auto;
	}
	.form-grid {
		grid-template-columns: 1fr;
	}
	.form-group.full-width {
		grid-column: auto;
	}
	.patient-form {
		padding: 20px;
	}
	.form-card-header {
		padding: 18px 20px;
	}
	.form-actions {
		flex-direction: column;
	}
	.save-btn, .cancel-btn {
		width: 100%;
		text-align: center;
	}
}
</style>
 

</head>

<body>

	 
	<!-- ==============================
     NAVBAR
============================== -->

	<div class="navbar">

		<h2>🏥 Hospital Management System</h2>

		<div>

			<a href="dashboard.jsp">Dashboard</a> <a href="logout">Logout</a>

		</div>

	</div>


	<!-- ==============================
     MAIN CONTENT
============================== -->

	<div class="container form-container">

		<!-- PAGE HEADER -->

		<div class="form-header">

			<div class="form-icon">🩺</div>

			<div>

				<h1>
					<%=isEdit ? "Edit Patient" : "Add New Patient"%>
				</h1>

				<p>
					<%=isEdit ? "Update the patient's medical and personal information"
		: "Register a new patient in the hospital system"%>
				</p>

			</div>

		</div>


		<!-- FORM CARD -->

		<div class="form-card">

			<div class="form-card-header">

				<h3>Patient Information</h3>

				<span> Please enter the patient's details carefully </span>

			</div>


			<!-- FORM -->

			<form class="patient-form" action="patient" method="post">

				<input type="hidden" name="action"
					value="<%=isEdit ? "update" : "insert"%>">

				<%
				if (isEdit) {
				%>

				<input type="hidden" name="id" value="<%=p.getId()%>">

				<%
				}
				%>


				<div class="form-grid">


					<!-- NAME -->

					<div class="form-group full-width">

						<label> Patient Name <span class="required">*</span>
						</label> <input type="text" name="name"
							placeholder="Enter patient's full name"
							value="<%=isEdit ? p.getName() : ""%>" required>

					</div>


					<!-- AGE -->

					<div class="form-group">

						<label> Age <span class="required">*</span>
						</label> <input type="number" name="age" min="0" max="120"
							placeholder="Enter age" value="<%=isEdit ? p.getAge() : ""%>"
							required>

					</div>


					<!-- GENDER -->

					<div class="form-group">

						<label> Gender <span class="required">*</span>
						</label> <select name="gender">

							<option
								<%=isEdit && "Male".equals(p.getGender()) ? "selected" : ""%>>
								Male</option>

							<option
								<%=isEdit && "Female".equals(p.getGender()) ? "selected" : ""%>>
								Female</option>

							<option
								<%=isEdit && "Other".equals(p.getGender()) ? "selected" : ""%>>
								Other</option>

						</select>

					</div>


					<!-- PHONE -->

					<div class="form-group">

						<label> Phone Number </label> <input type="text" name="phone"
							placeholder="Enter phone number"
							value="<%=isEdit ? p.getPhone() : ""%>">

					</div>


					<!-- DISEASE -->

					<div class="form-group">

						<label> Disease / Reason </label> <input type="text"
							name="disease" placeholder="Enter disease or reason for visit"
							value="<%=isEdit ? p.getDisease() : ""%>">

					</div>


					<!-- ADDRESS -->

					<div class="form-group full-width">

						<label> Address </label>

						<textarea name="address" rows="3"
							placeholder="Enter patient's complete address"><%=isEdit ? p.getAddress() : ""%></textarea>

					</div>


				</div>


				<!-- FORM ACTIONS -->

				<div class="form-actions">

					<a class="btn cancel-btn" href="patient?action=list">
						Cancel </a>

					<button type="submit" class="save-btn">
						<%=isEdit ? "✓ Update Patient" : "+ Save Patient"%>
					</button>

				</div>


			</form>

		</div>

	</div>


</body>

</html>
