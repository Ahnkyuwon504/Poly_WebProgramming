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
<h1><%=kiho%>번<br> <%=name%> 후보<br> 득표성향 분석</h1><br>
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
				<td width=100><p><%=i%>0대</p></td>
				<td><p>0(0%)</p></td>	
<%				
				} else {
					int redboxsize = 6 * rset.getInt(2);
					lengthOfbar = rset.getInt(1);
%>				
				<td width=100><p><%=i%>0대</p></td>
				<td><p><img src='./red.png' height=20px width=<%=redboxsize%>px>&nbsp;<%=rset.getInt(1)%>(<%=rset.getInt(2)%>%)</p></td>	
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
	} catch (Exception e) {
		out.println("모든 항목을 기입해 주십시오");
	}
%>
</table>
</body>
</html>