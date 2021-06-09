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
<title>Final</title>
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
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.20:33060/reservation", "root", "kopoctc");
		Statement stmt = conn.createStatement();
    	request.setCharacterEncoding("utf-8");
		
		String name = request.getParameter("name_key");
		String reserve_date = request.getParameter("reserve_date_key");
		String room = request.getParameter("room_key");
		String addr = request.getParameter("addr_key");
		String tel = request.getParameter("tel_key");
		String ipgum_name = request.getParameter("ipgum_name_key");
		String memo = request.getParameter("memo_key");
		String input_date = "now()";
		
		if (name.length() == 0 || addr.length() == 0 || tel.length() == 0 || ipgum_name.length() == 0 || memo.length() == 0) {
			out.print("<h1>모든 사항을 입력해 주십시오.</h1><br>");
			out.print("<a href='./ReservationStatus.jsp'>초기화면으로</a>");
			return;
		}
			
		String Query = "insert into reservation values ('" + name + "', '" + reserve_date + "', '" + room + "', '" + addr + "', '" + tel + "', '" + ipgum_name + "', '" + memo + "', " + input_date + ");";
		stmt.execute(Query);
					
		stmt.close();
		conn.close();
		
%>
	<h1>예약이 완료되었습니다.</h1>
	<a href='./ReservationStatus.jsp'>초기화면으로</a>

	
<%		
	} catch (Exception e) {
		out.print(e);
	}
%>

</body>
</html>