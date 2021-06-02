<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OneviewDB</title>
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
	PrintWriter pw = response.getWriter();
%>
<%
	String strid = request.getParameter("id");
	String QueryTxt = String.format("select * from examtable where id=" + strid + ";");
	ResultSet rset = stmt.executeQuery(QueryTxt);
%>
<table cellspacing=1 width=600 border=1>
<%
	while (rset.next()) {
		out.println("<h1>" + rset.getString(1) + " 학생 조회자료입니다.</h1>");
		out.println("<tr>");
		out.println("<td width=50><p align=center>이름</p></td>");
		out.println("<td width=50><p align=center>학번</p></td>");
		out.println("<td width=50><p align=center>국어</p></td>");
		out.println("<td width=50><p align=center>영어</p></td>");
		out.println("<td width=50><p align=center>수학</p></td>");
		out.println("</tr>");
		out.println("<tr>");
		out.println("<td width=50><p align=center>" + rset.getString(1) + "</p></td>");
		out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(2)) + "</p></td>");
		out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(3)) + "</p></td>");
		out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(4)) + "</p></td>");
		out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(5)) + "</p></td>");
		out.println("</tr>");
	}
	rset.close();
	stmt.close();
	conn.close();
	
%>
</table>
</table>
</body>
</html>