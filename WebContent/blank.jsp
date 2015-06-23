<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Blank User Jsp</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="style.css" type="text/css" />

</head>
<body>
<div id="page">
	<div id="logo">
			<table border="0">
			<tr>
			<td>
			<img src="customLogo.gif" width="200" height="50" alt="logo" />
			</td>
			<td>
			<img src="CSClogo.jpg" width="200" height="50" alt="logo" />
			</td>
			</tr>
			</table>
		</div>	
		 <div id="nav">
			 <ul>
				<li><a href="#/home.html">Home</a></li>
				<li><a href="#/about.html">About</a></li>
				<li><a href="#/contact.html">Contact</a></li>
				<li>
				<%
				if ((session.getAttribute("userid") != null) || (session.getAttribute("userid") != ""))
				{%>
					<a href='logout.jsp'>Log out</a>
				<%}
				%>
				</li>
			</ul>	
		 </div>
		 
		<div id="content">
		<%
    		if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
		%>
		You are not logged in<br/>
		<a href="index.jsp">Please Login</a>
		<%} else {
		%>
			
			
			
			
		<%}
		 %>
		</div>
	</div>

</body>
</html>