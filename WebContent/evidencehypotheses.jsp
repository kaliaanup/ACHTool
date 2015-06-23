<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Evidences and Hypotheses</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="style.css" type="text/css" />

</head>
<body>
<script type="text/javascript">
            function validate()
            {
            	var radios = document.forms['evidenceform'].elements['schemes'];
            	var texts = document.forms['evidenceform'].elements['evidences'];
            	var flag=0;
            	for(var i=0; i<radios.length; i++){
            		if(radios[i].checked)
            			flag=1;
            	}
            	if((texts.value).length != 0 && flag==1)
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
				<%if ((session.getAttribute("userid") != null) || (session.getAttribute("userid") != "")) {
					Integer qparam = Integer.parseInt(request.getParameter("questions"));
					Integer caseparam = Integer.parseInt(request.getParameter("case"));
					Integer methods = Integer.parseInt(request.getParameter("methods"));
				%>
					<li><a href='casestudydetails.jsp?case=<%= caseparam%>&methods=<%=methods%>'>Hypothesis</a></li>
				<%
				}
				 %>
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
		<h1>Search for evidence.</h1>
		<%@ page import ="java.sql.*" %>
		<%
    		if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
		%>
		You are not logged in<br/>
		<a href="index.jsp">Please Login</a>
		<%} else {
			Integer qparam = Integer.parseInt(request.getParameter("questions"));
			Integer cparam = Integer.parseInt(request.getParameter("case"));
			Integer methods = Integer.parseInt(request.getParameter("methods"));
			String hypothesis = request.getParameter("hypothesis");
			Integer schemes = null;
			if(request.getParameter("schemes") != null)
				schemes = Integer.parseInt(request.getParameter("schemes"));
			
			DriverManager.registerDriver(new com.mysql.jdbc.Driver());
	    	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/achtool","root", "admin");
	    	Statement st = con.createStatement();
			ResultSet rs;
			
			Statement st1 = con.createStatement();
			ResultSet rs1;
			
			Statement st2 = con.createStatement();
			ResultSet rs2;
			
	    	java.util.Date date = new java.util.Date();
	    	Object paramdt = new java.sql.Timestamp(date.getTime());
	    	rs=st.executeQuery("select id from members where username='"+session.getAttribute("userid")+"'");
	    	if(rs.next())
	    	{
	    		Integer userid = Integer.parseInt(rs.getString(1));
	    		st.executeUpdate("insert into userlogs (userid,userevent,eventtime) VALUES ("+userid+",'selected_case"+cparam+"_question_"+qparam+"_methods="+methods+"_hypothesis="+hypothesis+"','"+paramdt+"')");
	    	}
			
	    	if(methods == 2)
	    	{
	    	%>
	    	<tr><td align="center"><h2>Hypothesis: <font color="Blue"><%=hypothesis%></font></h2></td></tr>
	    	<center>
	    	<form name="evidenceform" method="get" action="results.jsp" onsubmit="return validate()">
	    	<input type="hidden" name="questions" value=<%= qparam%>>
	    	<input type="hidden" name="case" value=<%= cparam%>>
	    	<input type="hidden" name="methods" value=<%=methods%>>
	    	<input type="hidden" name="hypothesis" value="<%=hypothesis%>">
	    	
	    	<table border="1" width="30%" cellpadding="3">
			<tr><td align="center"><h2>Select a Scheme</h2></td></tr>
			
			
			<tr><td><input type="radio" name="schemes" value=1 <% if(schemes != null && schemes.equals(1)) {%> checked <%}%>>Argument from Expert Opinion</td></tr>
			<tr><td><input type="radio" name="schemes" value=2 <% if(schemes != null && schemes.equals(2)) {%> checked <%}%>>Argument from Public Fear</td></tr>
			<tr><td><input type="radio" name="schemes" value=3 <% if(schemes != null && schemes.equals(3)) {%> checked <%}%>>Argument from Entity-Location-Hostility</td></tr>
			<tr><td><input type="radio" name="schemes" value=4 <% if(schemes != null &&  schemes.equals(4)) {%> checked <%}%>>Argument from History</td></tr>
			
			<tr><td align="center"><h2>Enter a Keyword</h2></td></tr>
			<tr><td align="center"><input type="text" name="evidences" value=""  size="50"/></td></tr>
			<tr><td align="center"><input type="submit" name="submit" value="SEARCH"></td></tr>
			
			</table>
			</form>
			</center>
		
			<%
	    	}
	    	else
	    	{%>
	    	    <tr><td align="center"><h2>Hypothesis: <font color="Blue"><%=hypothesis%></font></h2></td></tr>
	    		<center>
	    		<form name="evidenceform" method="get" action="results.jsp" onsubmit="return validate()">
	    		<input type="hidden" name="questions" value=<%= qparam%>>
	    		<input type="hidden" name="case" value=<%= cparam%>>
	    		<input type="hidden" name="methods" value=<%=methods%>>
	    		<input type="hidden" name="hypothesis" value="<%=hypothesis%>">
	    	
	    		<table border="1" width="30%" cellpadding="3">
				<tr><td align="center"><h2>Enter a keyword</h2></td></tr>
				<tr><td align="center"><input type="text" name="evidences" value=""  size="50"/></td></tr>
				
				
				<tr><td align="center"><input type="submit" name="submit" value="SEARCH"></td></tr>
				
				
				
			
				</table>
			</form>
			</center>
	    				
	    	<%}
	    	
			}
		
		
		
		
		
		 %>
		</div>
	</div>

</body>
</html>