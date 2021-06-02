<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deleteDB</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
<%
	try {
		request.setCharacterEncoding("utf-8");
		
		String id = request.getParameter("studentid");
		
		String QueryTxt = String.format("delete from examtable where id=" + id + ";");
		stmt.execute(QueryTxt);
		QueryTxt = String.format("select * from examtable;");
		ResultSet rset = stmt.executeQuery(QueryTxt);
		
		out.println("<h1>해당 레코드 삭제</h1>");
		out.println("<table>");
		
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
			out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(2)) + "</p></td>");
			out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(3)) + "</p></td>");
			out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(4)) + "</p></td>");
			out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(5)) + "</p></td>");
			out.println("</tr>");	
		}
		
		out.println("</table>");
		
		rset.close();
		stmt.close();
		conn.close();
		
	} catch (SQLSyntaxErrorException se) {
		out.println("TABLE이 없습니다. 생성 후 넣어 주십시오.");
	} catch (SQLIntegrityConstraintViolationException ve) {
		out.println("이미 지정되어 있는 학번입니다.<br>");
		out.println("다른 학번으로 지정해 주십시오.");
	} catch (NumberFormatException nfe) {
		out.println("기입 항목을 다시 한 번 확인해 주십시오.<br>");
		out.println("숫자가 아닌 수를 기입하셨는지 혹은 공란이 존재하는지 확인 바랍니다..<br>");
	} catch (Exception e) {
		out.println("모든 항목을 기입해 주십시오");
	}
%>
</body>
</html>