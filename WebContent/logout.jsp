<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@ page import ="java.sql.*" %>
<%@ page import ="java.sql.Date" %>
<%
if ((session.getAttribute("userid") != null) || (session.getAttribute("userid") != "")) {
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
	st.executeUpdate("insert into userlogs (userid,userevent,eventtime) VALUES ("+userid+",'logged_out','"+paramdt+"')");
}
	session.setAttribute("userid", null);
	
	session.invalidate();
	response.sendRedirect("index.jsp");
}
%>
</body>
</html>