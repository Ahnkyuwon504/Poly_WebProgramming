<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>C01</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style>
table {
	border: 1px solid black;
	border-collapse: collapse;
	width : 100%;
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
		String QueryTxt;
		ResultSet rset;
		
		String kiho = request.getParameter("kiho_key");
		String name = "";
		
		QueryTxt = "select name from hubo where kiho=" + kiho + ";";
		rset = stmt.executeQuery(QueryTxt);
		
		while (rset.next()) {
			name = rset.getString(1);
		}
%>
<h1><%=kiho%>번 <%=name%> 후보 득표성향 분석</h1><br>
<table>
<%			
		int lengthOfbar = 0;

		for (int i = 1; i <= 9; i++) {
		
			QueryTxt = "select count(*), count(*) * 100 / (select count(*) from tupyo where kiho=" + kiho + ") from tupyo where kiho=" + kiho + " and age=" + i + ";";
			rset = stmt.executeQuery(QueryTxt);
			
			while (rset.next()) {
				
%>
				<tr>
<%				
				if (rset.getInt(1) == 0) {   
					lengthOfbar = 0;
%>
				<td width=50><p align=center><%=i%>0대</p></td>
				<td width=50><p align=center>0(0%)</p></td>	
<%				
				} else {
					lengthOfbar = rset.getInt(1);
%>				
				<td width=50><p align=center><%=i%>0대</p></td>
				<td width=50><p align=center><%=rset.getInt(1)%>(<%=rset.getInt(2)%>%)</p></td>	
<%				
				}
%>
				</tr>
<%
			}
		}
		
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
		out.println(e);
	}
%>
</table>
</body>
</html>