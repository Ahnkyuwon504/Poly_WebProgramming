<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>dropDB</title>
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
	try {
		String QueryTxt;
		
		QueryTxt = String.format(
			"drop table examtable;");			
		
		stmt.execute(QueryTxt);

		stmt.close();
		conn.close();
		pw.printf("<h1>TABLE 삭제 완료</h1><br>");
	} catch (Exception e) {
		pw.printf("<h1>이미 TABLE이 삭제되었습니다.</h1><br>");
		pw.printf("<h1>TBL 생성을 눌러주십시오.</h1><br>");
	}
%>
</body>
</html>