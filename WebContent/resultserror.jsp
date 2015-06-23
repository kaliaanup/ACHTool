<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Results</title>
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
		<h1>Here is the list of evidences based on your keyword</h1>
		<%@ page import ="java.sql.*" %>
		<%
    		if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
		%>
		You are not logged in<br/>
		<a href="index.jsp">Please Login</a>
		<%} else {
			String searchStr = request.getParameter("evidences");
			DriverManager.registerDriver(new com.mysql.jdbc.Driver());
	    	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/achtool","root", "admin");
	    	Statement st = con.createStatement();
	    	Statement st1 = con.createStatement();
	    	ResultSet rs;
	    	ResultSet rs1;
	    	if(searchStr != "" || searchStr != "%" || searchStr != "-" ||
	    	   searchStr != "+" || searchStr != "(" || searchStr != ")" || 
	    	   searchStr != "$" || searchStr != "#" || searchStr != "@" || 
	    	   searchStr != "!" || searchStr != "[" || searchStr != "]" ||
	    	   searchStr != "1" || searchStr != "|" || searchStr != "\\" ||
	    	   searchStr != "2" || searchStr != "^" || searchStr != "&"||
	    	   searchStr != "3" || searchStr != "*" || searchStr != "`"||
	    	   searchStr != "4" || searchStr != "~" || searchStr != "/" ||
	    	   searchStr != "?" || searchStr != "<" || searchStr != ">" ||
	    	   searchStr != "?" || searchStr != "," || searchStr != "."||
	    	   searchStr != "?" || searchStr != "\"" || searchStr != "'"||
   			   searchStr != "_" || searchStr != "0" ||searchStr != "5" ||
   			   searchStr != "6" ||searchStr != "7" ||searchStr != "8" ||
   			   searchStr != "9")
	    	{
	    	rs1 = st1.executeQuery("select keyword from achtool.keywords where keyword='"+searchStr+"'");
	    	if(rs1.next())
	    	{
	    	rs = st.executeQuery("select evidence from achtool.evidences where evidence LIKE '%"+searchStr+"%'");
			%>
			
			<center>
			
			 <table>
			 <%
		    	while (rs.next()) {
		    	String result=	rs.getString(1);
		    	
		      %>
				<tr><td><%out.println(result);%></td></tr>
			<%}
	    	  }
	    	
	    	 }
	    	 else
	    	 {
	    		
	    	 }
			 %>
			
			</table>
		</center>
			
			
		<%}
		 %>
		</div>
	</div>

</body>
</html>