<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>createDB</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	$(function() {
		$("#insertButton").click(function() {
		alert('헤헤');
		});
	});
</script>
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
			"create table examtable (name varchar(20) not null, id int not null primary key, kor int, eng int, mat int);");			
		
		stmt.execute(QueryTxt);

		stmt.close();
		conn.close();
		pw.printf("<h1>TABLE 생성 완료</h1><br>");
	} catch (Exception e) {
		pw.printf("<h1>이미 TABLE이 생성되었습니다.</h1><br>");
		pw.printf("<h1>TBL 삭제 또는 값 넣기를 눌러주십시오.</h1><br>");
	}
%>
</body>
</html>