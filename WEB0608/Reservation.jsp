<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reservation</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	function submit2(frm) {
		frm.action='./A02.jsp';
		frm.method='post';
		frm.target='main';
		frm.submit();
		return true;
	}
</script>
</head>

<body>
<%
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.20:33060/kopoctc_HW4", "root", "kopoctc");
	Statement stmt = conn.createStatement();
	
%>
<%
try {
	ResultSet rset = stmt.executeQuery("select * from reservation;");
	
	while (rset.next()) {
%>
		<%=rset.getString(1)%>
<%
	}
	
	rset.close();
	stmt.close();
	conn.close();
} catch (SQLSyntaxErrorException se) {
	out.println(se);
} catch (Exception e) {
	out.println(e);
}
%>
		
</body>
</html>