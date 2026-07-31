<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hospital Login</title>

<style>

body{
font-family:Arial;
background:#f4f4f4;
}

.container{

width:350px;
margin:100px auto;
background:white;
padding:20px;
border-radius:10px;
text-align:center;
box-shadow:0 0 10px gray;

}

input{

width:90%;
padding:10px;
margin:10px;

}

button{

padding:10px 20px;

}

</style>

</head>

<body>

<div class="container">

<h2>Hospital Management System</h2>

<form action="LoginServlet" method="post">

<input type="text"
name="username"
placeholder="Username"
required>

<input type="password"
name="password"
placeholder="Password"
required>

<button type="submit">
Login
</button>

</form>

<%
String msg=(String)request.getAttribute("msg");

if(msg!=null){
%>

<p style="color:red;">
<%=msg%>
</p>

<%
}
%>

</div>

</body>
</html>