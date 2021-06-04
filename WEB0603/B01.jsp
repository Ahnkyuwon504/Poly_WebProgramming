<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>A01</title>
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
	ResultSet rset = stmt.executeQuery("select * from hubo;");
	
	if (!rset.isBeforeFirst() ) {    
		out.println("아직 등록된 후보가 없습니다.<br>"); 
		out.println("상단의 탭을 참조해 후보를 등록해 주십시오."); 
		return;
	}
%>
	<form action='./B02.jsp' method='post' target='main'>
	<select name='kiho_key'>
<%	
	while (rset.next()) {
%>
		<option value='<%=rset.getInt(1)%>'><%=rset.getInt(1)%>번 <%=rset.getString(2)%></option>
<%
	}
	
	rset.close();
	stmt.close();
	conn.close();
	} catch (Exception e) {
		out.println(e);
	}
%>
	</select>
	<select name='age_key'>
		<option value='1'>10대</option>
		<option value='2'>20대</option>
		<option value='3'>30대</option>
		<option value='4'>40대</option>
		<option value='5'>50대</option>
		<option value='6'>60대</option>
		<option value='7'>70대</option>
		<option value='8'>80대</option>
		<option value='9'>90대</option>
	</select>
	<input type='submit' value='투표하기'>
	</form>
</body>
</html>