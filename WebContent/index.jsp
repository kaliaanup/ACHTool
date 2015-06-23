<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Login Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="style.css" type="text/css" />
</head>
<body>
<script type="text/javascript">
            function validate()
            {
            	var username = document.forms['loginform'].elements['username'];
            	var password = document.forms['loginform'].elements['password'];
            	var flag=0;
            	
            	if((username.value).length != 0 && (password.value).length != 0)
            	{
    				return true;
            	}
            	else
            		{
            	alert('You must provide a username and a password!');
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
				<li><a href="contact.jsp">Contact</a></li>
			</ul>	
		 </div>
		<div id="content">
		<center>
		<form name="loginform" method="post" action="login.jsp" onsubmit="return validate()">
           <table border="1" width="30%" cellpadding="3">
                <thead>
                    <tr>
                        <th colspan="2">Login Here</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>User Name</td>
                        <td><input type="text" name="username" value="" /></td>
                    </tr>
                    <tr>
                        <td>Password</td>
                        <td><input type="password" name="password" value="" /></td>
                    </tr>
                    <tr>
                    <td></td>
                    <td>
                        <table>
                        <tr>
                        <td><input type="submit" value="Login" /></td>
                        <td><input type="reset" value="Reset" /></td>
                        </tr>
                        </table>
                     </td>
                    </tr>
                    <tr>
                        <td colspan="2">Not Registered!! <a href="reg.jsp"><font color="red">Register Here</font></a></td>
                    </tr>
                </tbody>
            </table>
         </form>
         </center>
        </div>
  <div id="footer">
			<p>
				Prepared by Anup Kalia
			</p>
		</div>
			</div>
</body>
</html>