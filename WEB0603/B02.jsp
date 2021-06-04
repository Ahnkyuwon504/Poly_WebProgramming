<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>B02</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
<%
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.20:33060/kopoctc", "root", "kopoctc");
	Statement stmt = conn.createStatement();
%>
<%
	try {
		request.setCharacterEncoding("utf-8");
		
		String kiho = request.getParameter("kiho_key");
		String age = request.getParameter("age_key");
		
		out.println("<h1>투표 결과</h1><br>");
		out.println(kiho + "번 후보 " + age + "0대로 투표 완료");
		
		stmt.execute("insert into tupyo (kiho, age) values (" + kiho + ", " + age + ");");
		
		stmt.close();
		conn.close();
	} catch (Exception e) {
		out.println("모든 항목을 기입해 주십시오");
	}
%>
</body>
</html>