<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reservation</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>

<body>
	<h1>예약하기</h1>
	<form action='./Final.jsp' method='post'>
		<p>성명 <input name='name_key' type='text'></p>
		<p>예약일자 <input  name='reserve_date_key' type='text'></p>
		<p>예약방
			<select name='room_key'>
				<option value='1'>Suite</option>
				<option value='2'>Superior</option>
				<option value='3'>Standard</option>
			</select>
		</p>
		<p>주소 <input  name='addr_key' type='text'></p>
		<p>전화번호 <input  name='tel_key' type='text'></p>
		<p>입금자명 <input  name='ipgum_key' type='text'></p>
		<p>남기실말 <input  name='memo_key' type='text'></p>
		<input type='submit' value='예약하기'>
	</form>
		
		
<%
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.20:33060/reservation", "root", "kopoctc");
		Statement stmt = conn.createStatement();
		ResultSet rset;
		
	} catch (Exception e) {
		out.print(e);
	}

%>

		

</body>
</html>