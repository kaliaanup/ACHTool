<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Case Study Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="style.css" type="text/css" />

</head>
<body>
<script type="text/javascript">
				function validate()
				{
					var texts = document.forms['hypothesesform'].elements['hypothesis'];
					if((texts.value).length != 0)
					{
						return true;
					}
					else
						{
					alert('You must select a scheme and search for a keyword!');
					return false;
						}
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
		<h1>Thanks for selecting the case study. We have the following questions for you.</h1>
		<%@ page import ="java.sql.*" %>
		<%
		
		Integer param = Integer.parseInt(request.getParameter("case"));
		Integer methods = Integer.parseInt(request.getParameter("methods"));

		DriverManager.registerDriver(new com.mysql.jdbc.Driver());
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/achtool","root", "admin");
		Statement st = con.createStatement();
		Statement st2 = con.createStatement();
		
		ResultSet rs;
		ResultSet rs1;
		ResultSet rs2;
		
    	java.util.Date date = new java.util.Date();
    	Object paramdt = new java.sql.Timestamp(date.getTime());
    	rs1=st.executeQuery("select id from members where username='"+session.getAttribute("userid")+"'");
    	if(rs1.next())
    	{
    		Integer userid = Integer.parseInt(rs1.getString(1));
    		st.executeUpdate("insert into userlogs (userid,userevent,eventtime) VALUES ("+userid+",'selected_casestudy_"+param+"_methods_"+methods+"','"+paramdt+"')");
    	}
		
    	
		rs = st.executeQuery("select questionid from casestudyquestions where casestudyid="+param);
				
		%>
		<center>
			 <form name="hypothesesform" method="get" action="evidencehypotheses.jsp" onsubmit="return validate()">
			 <input type="hidden" name="case" value=<%= param%>>
			 
			 <table>
			 <%
		    	while (rs.next()) {
		    	Integer qid=Integer.parseInt(rs.getString(1));
		    	rs2 = st2.executeQuery("select id,question from questions where id="+qid);
		    	
		    	while(rs2.next())
		    	{
		    		Integer id=Integer.parseInt(rs2.getString(1));
		    		String result=	rs2.getString(2);
		      %>
				<tr>
					<input type="hidden" name="questions" value=<%= qid%>>
					<input type="hidden" name="methods" value=<%= methods%>>
					
					<tr><td><h1><font color="blue"><%out.println(result);%></font></h1></td></tr>
				</tr>
				<tr>
					<tr><td align="center"><input type="text" name="hypothesis" value=""  size="50"/></td></tr>
				</tr>
			 <%} 
			}%>
			<tr><td align="center"><input type="submit" name="submit" value="EnterAHypothesis"></td></tr>
			</table>
			</form>
		</center>	
		<%}
    	 %>
		</div>
	</div>

</body>
</html>