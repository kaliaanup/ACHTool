<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Welcome Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="style.css" type="text/css" />
</head>
<body>
 <script type="text/javascript">
            function validate()
            {
            	var radios = document.forms['casestudiesform'].elements['case'];
            	var radios1 = document.forms['casestudiesform'].elements['methods'];
            	var flag=0;
            	var flag1=0;
            	for(var i=0; i<radios.length; i++){
            		if(radios[i].checked) flag=1;
            	}
            	for(var i=0; i<radios1.length; i++){
            		if(radios1[i].checked) flag1=1;
            	}
            	if(flag==1 && flag1==1)
            		return true;
            	alert('You must select both the case study and !');
            	return false;
            };

        </script>
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
			 	<%
    			if ((session.getAttribute("userid") != null) || (session.getAttribute("userid") != "")) {
    			%>
    			<li><a href='success.jsp'>Home</a></li>
				<%}%>
			
				<li><a href="contact.jsp">Contact</a></li>
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
		<h1>Welcome <%=session.getAttribute("userid")%>. We have the following case studies for you. Choose one from the following.</h1>
		<%@ page import ="java.sql.*" %>
		<%@ page import ="java.sql.Date" %>
		<%
		DriverManager.registerDriver(new com.mysql.jdbc.Driver());
    	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/achtool","root", "admin");
    	Statement st = con.createStatement();
    	ResultSet rs1;
    	java.util.Date date = new java.util.Date();
    	Object paramdt = new java.sql.Timestamp(date.getTime());
    	rs1=st.executeQuery("select id from members where username='"+session.getAttribute("userid")+"'");
    	if(rs1.next())
    	{
    		Integer userid = Integer.parseInt(rs1.getString(1));
    		st.executeUpdate("insert into userlogs (userid,userevent,eventtime) VALUES ("+userid+",'logged_in','"+paramdt+"')");
    	}
    	ResultSet rs;
    	
    	rs = st.executeQuery("select id,casestudy from casestudies");
    	%>
    	<center>
    	<form name="casestudiesform" method="get" action="casestudydetails.jsp" onsubmit="return validate()">
		<table border="1" width="30%" cellpadding="3">
    	<%
    	while (rs.next()) {
    	Integer id = Integer.parseInt(rs.getString(1));
    	String result=	rs.getString(2);
    	
    	%>
			<tr><td><input type="radio" name="case" value=<%= id%>><% out.println(result);%></td></tr>
			
		<%} %>
		
		<tr><td align="center"><h1>Choose the methodology you have been assigned.</h1></td></tr>
		<tr><td><input type="radio" name="methods" value=1>ACH</td></tr>
		<tr><td><input type="radio" name="methods" value=2>Arg-ACH</td></tr>
		
		<tr><td><input type="submit" name="submit" value="submit"></td></tr>
		</table>
		</form>
		</center>
		<%
		 }
		%>
			
			
</div>
 <div id="footer">
			<p>
				Prepared by Anup Kalia
			</p>
		</div>
			


</div>
</body>
</html>