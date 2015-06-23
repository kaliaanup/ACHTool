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
					<li><a href='casestudydetails.jsp?case=<%= caseparam%>&methods=<%=methods %>'>Hypothesis</a></li>
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
		<%String searchStr = request.getParameter("evidences"); %>
		<h1>Here is a list of evidence based on your keyword <font color="blue">'<%= searchStr%>'</font></h1>
		<%@ page import ="java.sql.*" %>
		<%@ page import ="utility.WordnetDictionary" %>
		
		<%
    		if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
		%>
		You are not logged in<br/>
		<a href="index.jsp">Please Login</a>
		<%} else {
			
			int count =0;
			int currcid=0;
			int prevcid=0;
			DriverManager.registerDriver(new com.mysql.jdbc.Driver());
	    	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/achtool","root", "admin");
	    	//get question id
	    	Integer qparam = Integer.parseInt(request.getParameter("questions"));
	    	//get category id
	    	//Integer cparam = Integer.parseInt(request.getParameter("categories"));
	    	Integer caseparam = Integer.parseInt(request.getParameter("case"));
	    	Integer methods = Integer.parseInt(request.getParameter("methods"));
	    	Integer schemes = new Integer(0);
	    	if(methods == 2)
	    	{
	    		schemes = Integer.parseInt(request.getParameter("schemes"));
	    	}
	    	String hypothesis = request.getParameter("hypothesis");
	    	
	    	String dictSearchStr="";
	    	Statement st = con.createStatement();
	    	Statement st1 = con.createStatement();
	    	Statement st2 = con.createStatement();
	    	Statement st3 = con.createStatement();
	    	Statement st4 = con.createStatement();
	    	Statement st5 = con.createStatement();
	    	
	    	ResultSet rs;
	    	ResultSet rs1;
	    	ResultSet rs2;
	    	ResultSet rs3;
	    	ResultSet rs4;
	    	ResultSet rs5;
	    	%>
	    	<center>
			 <table style="float: right;">
			 <h1>Hypothesis:<font color="blue"><%=hypothesis %></font></h1>
			 <%
	    	if(methods == 2)
	    	{
	    		if(schemes == 1)
	    		{
	    			//expert opinion
	    			%>
	    				<h1>Selected Scheme:<font color="blue">Argument from Expert Opinion</font></h1>
	    				<tr><td></td><td><img src="expert-opinion.jpg" height="600" width="600"></td></tr>
	    			<%
	    		}
	    		else if(schemes == 2)
	    		{
	    			//expert opinion
	    			%>
	    				<h1>Selected Scheme:<font color="blue">Argument from Public Fear</font></h1>
	    				<tr><td></td><td><img src="public-fear.jpg" height="600" width="600"></td></tr>
	    			<%
	    		}
	    		else if(schemes == 3)
	    		{
	    			//expert opinion
	    			%>
	    				<h1>Selected Scheme:<font color="blue">Argument from Entity-Location-Hostility</font></h1>
	    				<tr><td></td><td><img src="entity-location-hostility.jpg" height="600" width="600"></td></tr>
	    			<%
	    		}
	    		else if(schemes == 4)
	    		{
	    			//expert opinion
	    			%>
	    				<h1>Selected Scheme:<font color="blue">Argument from History</font></h1>
	    				<tr><td></td><td><img src="history.jpg" height="600" width="600"></td></tr>
	    			<%
	    		}
	    	
	    	
	    	}
			 %>
			 </table>
		    	</center>
		    	<center>
			 <table >
				 <%
	    	java.util.Date date = new java.util.Date();
	    	Object paramdt = new java.sql.Timestamp(date.getTime());
	    	rs=st.executeQuery("select id from members where username='"+session.getAttribute("userid")+"'");
	    	if(rs.next())
	    	{
	    		Integer userid = Integer.parseInt(rs.getString(1));
	    		if(methods == 2)
	    		{
	    			st.executeUpdate("insert into userlogs (userid,userevent,eventtime) VALUES ("+userid+",'selected_case"+caseparam+"_question_"+qparam+"_methods="+methods+"_hypothesis="+hypothesis+"_scheme_"+schemes+"_searched_"+searchStr+"','"+paramdt+"')");
	    		}
	    		else
	    		{
	    			st.executeUpdate("insert into userlogs (userid,userevent,eventtime) VALUES ("+userid+",'selected_case"+caseparam+"_question_"+qparam+"_methods="+methods+"_hypothesis="+hypothesis+"_searched_"+searchStr+"','"+paramdt+"')");
	    		}
	    		
	    	}
	    	
	    	
	    	if(!(searchStr.equals("") || searchStr.equals("%") || searchStr.equals("-") ||
	    	   searchStr.equals("+") ||searchStr.equals("(") || searchStr.equals(")") || 
	    	   searchStr.equals("$") || searchStr.equals("#") || searchStr.equals("@") || 
	    	   searchStr.equals("!") || searchStr.equals("[") || searchStr.equals("]") ||
	    	   searchStr.equals("1") || searchStr.equals("|") || searchStr.equals("\\") ||
	    	   searchStr.equals("2") || searchStr.equals("^") || searchStr.equals("&") ||
	    	   searchStr.equals("3") || searchStr.equals("*") || searchStr.equals("`") ||
	    	   searchStr.equals("4") || searchStr.equals("~") || searchStr.equals("/") ||
	    	   searchStr.equals("?") || searchStr.equals("<") || searchStr.equals(">") ||
	    	   searchStr.equals("?") || searchStr.equals(",") || searchStr.equals(".") ||
	    	   searchStr.equals("?") || searchStr.equals("\"") || searchStr.equals("'")||
	    	   searchStr.equals("_") || searchStr.equals("0") || searchStr.equals("5") ||
	    	   searchStr.equals("6") || searchStr.equals("7") ||searchStr.equals("8") ||
	    	   searchStr.equals("9")))
	    	{
	    		WordnetDictionary.openDictionaryConnection();
	    		dictSearchStr = WordnetDictionary.getBaseForm(searchStr);
	    		
	    		rs1 = st1.executeQuery("select keyword from keywords where keyword='"+searchStr+"'");	
	    		rs4 = st4.executeQuery("select keyword from keywords where keyword='"+dictSearchStr+"'");	
	    	
	    	if(rs1.next())
	    	{
	    			rs2 = st2.executeQuery("select categoryid, evidenceid from categoryevidences");
	    			count =0;prevcid=0; currcid=0;
			 	while (rs2.next()) 
		    	{
			 		Integer cid = Integer.parseInt(rs2.getString(1));
		    		currcid = cid;
		    		
		    		//out.println("prev"+prevcid);
			    	//out.println("curr"+currcid);
			    	if (prevcid != currcid )
		    		{
		    			count =0;
		    		}
			    	
			    	
		    		
		    		Integer eid = Integer.parseInt(rs2.getString(2));
		    		Integer id = new Integer(0);
		    		String cresult = new String();
		    		String description = new String();
		    		
		    		
		    		rs5 = st5.executeQuery("select id,category,cdescription from categories where id="+cid);
		    		if(rs5.next())
			    	{
			    		id = Integer.parseInt(rs5.getString(1));
						cresult = rs5.getString(2);
						description=rs5.getString(3);
						
						
			    		rs3 = st3.executeQuery("select evidence from evidences where id ="+eid+"  AND evidence LIKE '%"+searchStr+"%'");
			    		while(rs3.next())
				    	{
					    		String result=	rs3.getString(1);
					    		//out.println("count"+count);    		
						    	if(count == 0)
						    	{
						    		count = count+1;
						    	%>
							     	 <tr><td align="center"><h2><%out.println(cresult);%></h2></td><td></td></tr>
							     	 
							    <%
									 	
								 }
						    	%>
						    	
								 	<tr><td><li><%out.println(result);%></li></td><td></td></tr>
								<%
						}
				      }
		    		
		    		prevcid = currcid;
		    		
		    		
	    	   	  }
			if(methods == 2)
			{
				 out.println("Want to <a href='evidencehypotheses.jsp?case="+caseparam+"&questions="+qparam+"&methods="+methods+"&hypothesis="+hypothesis+"&schemes="+schemes+"'><font color=\"red\">search again</font></a>");
				 out.println("<BR>");
				 out.println("---------------------------------------------------------------------------------");
			}
			else
			{
				out.println("Want to <a href='evidencehypotheses.jsp?case="+caseparam+"&questions="+qparam+"&methods="+methods+"&hypothesis="+hypothesis+"'><font color=\"red\">search again</font></a>");
				out.println("<BR>");
				out.println("---------------------------------------------------------------------------------");
			}
			
	    	}
	    	else if(rs4.next())
	    	{
	    		prevcid =0;currcid=0; count=0;
		    	//out.println("Entered second if");
		    	//rs2 = st2.executeQuery("select evidence from evidences where evidence LIKE '%"+searchStr+"%'");
		    	rs2 = st2.executeQuery("select categoryid, evidenceid from categoryevidences");
		    	Integer id = new Integer(0);
		    	String cresult = new String();
		    	String description = new String();
		    	 count = 0;
		    	 
			    	while (rs2.next())
			    	{
				    	//String result=	rs.getString(1);
				    	Integer cid = Integer.parseInt(rs2.getString(1));
				    	currcid = cid;
				    	
				    	//out.println("prev"+prevcid);
				    	//out.println("curr"+currcid);
				    	if (prevcid != currcid )
			    		{
			    			count =0;
			    		}
				    	
				    	Integer eid = Integer.parseInt(rs2.getString(2));
				    	rs5 = st5.executeQuery("select id,category,cdescription from categories where id="+cid);
				    	if(rs5.next())
				    	{
				    		id = Integer.parseInt(rs5.getString(1));
							cresult = rs5.getString(2);
							description=rs5.getString(3);
							
							 
							rs3 = st3.executeQuery("select evidence from evidences where id ="+eid+"  AND evidence LIKE '%"+dictSearchStr+"%'");
							
					    	while(rs3.next())
					    	{
					    		String result=	rs3.getString(1);
					    		//out.println("count"+count);    	
					     		if(count == 0)
					    		{
					     			count = count +1;
					    		 	%>
					     	 			<tr><td align="center"><h1><%out.println(cresult);%></h1></td></tr>
					     	   <%
					     		
					    		}%>
								<tr><td><li><%out.println(result);%></li></td><td></td></tr>
							<%}
				    	 }
				    	prevcid = currcid;
			    	}
				 if(methods == 2)
				 {
			    	 out.println("Want to <a href='evidencehypotheses.jsp?case="+caseparam+"&questions="+qparam+"&methods="+methods+"&hypothesis="+hypothesis+"&schemes="+schemes+"'><font color=\"red\">search again</font></a>");
					 out.println("<BR>");
					 out.println("---------------------------------------------------------------------------------");
				 }
				 else
				 {
					 out.println("Want to <a href='evidencehypotheses.jsp?case="+caseparam+"&questions="+qparam+"&methods="+methods+"&hypothesis="+hypothesis+"'><font color=\"red\">search again</font></a>");
					 out.println("<BR>");
					 out.println("---------------------------------------------------------------------------------");
				 }
	    	  }
    		 else
    		 {
    			 if(methods == 2)
    			 {
    				 out.println("Invalid keyword <a href='evidencehypotheses.jsp?case="+caseparam+"&questions="+qparam+"&methods="+methods+"&hypothesis="+hypothesis+"&schemes="+schemes+"'>try again</a>");
    			 }
    			//String param = request.getParameter("questions").toString();
    			else
    			{
    				out.println("Invalid keyword <a href='evidencehypotheses.jsp?case="+caseparam+"&questions="+qparam+"&methods="+methods+"&hypothesis="+hypothesis+"'>try again</a>");
    			}
    		 }
	    	//WordnetDictionary.closeDictionaryConnection();
	    	 }
	    	 else
	    	 {
	    		 if(methods == 2)
	    		 {
	    			 
	    		 }
	    		 else
	    		 {
	    		 //String param = request.getParameter("questions").toString();
	    		 	out.println("Invalid keyword <a href='evidencehypotheses.jsp?case="+caseparam+"&questions="+qparam+"&methods="+methods+"&hypothesis="+hypothesis+"&schemes="+schemes+"'>try again</a>");
	    		 }
	    	 }
	    	}
	    	
	    	
			 %>
			
			</table>
		</center>
			
			
		
		</div>
	</div>

</body>
</html>