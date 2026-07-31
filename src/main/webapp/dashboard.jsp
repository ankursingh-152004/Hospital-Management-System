<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="model.Patient"%>

<%
Patient user=(Patient)session.getAttribute("user");

if(user==null){

response.sendRedirect("login.jsp");
return;

}
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Dashboard</title>

</head>

<body>

<h1>Welcome <%=user.getUsername()%></h1>

<h2>Role : <%=user.getRole()%></h2>

<hr>

<a href="LogoutServlet">Logout</a>

</body>

</html>