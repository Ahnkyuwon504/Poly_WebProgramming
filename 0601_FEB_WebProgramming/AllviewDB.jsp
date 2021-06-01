<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AllviewDB</title>
<style>
table {
	border: 1px solid black;
	border-collapse: collapse;
}

th, td {
	border: 1px solid black;
	padding: 5px;
}
</style>
</head>

<body>
<%
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.20:33060/kopoctc", "root", "kopoctc");
	Statement stmt = conn.createStatement();
	
%>
<table cellspacing=1 width=600 border=1>
<%
try {
	ResultSet rset = stmt.executeQuery("select * from examtable;");
	String studentid;
	
	out.println("<tr>");
	out.println("<td width=50><p align=center>이름</p></td>");
	out.println("<td width=50><p align=center>학번</p></td>");
	out.println("<td width=50><p align=center>국어</p></td>");
	out.println("<td width=50><p align=center>영어</p></td>");
	out.println("<td width=50><p align=center>수학</p></td>");
	out.println("</tr>");
	
	while (rset.next()) {
		out.println("<tr>");
		out.println("<td width=50><p align=center>" + rset.getString(1) + "</p></td>");
		studentid = Integer.toString(rset.getInt(2));
		out.println("<td width=50><p align=center><a name='studentid' href='./OneviewDB.jsp?id=" + studentid + "' target=_self type='submit'>" + Integer.toString(rset.getInt(2)) + "</a></p></td>");
		out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(3)) + "</p></td>");
		out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(4)) + "</p></td>");
		out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(5)) + "</p></td>");
		out.println("</tr>");
	}
	rset.close();
	stmt.close();
	conn.close();
	} catch (SQLSyntaxErrorException se) {
		out.println("TABLE이 없습니다. 생성 후 넣어 주십시오.");
	} catch (Exception e) {
		out.println(e);
	}
%>
</table>
</body>
</html>