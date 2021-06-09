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
<title>ReservationStatus</title>
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

<body align="center">
	<h1>예약상황</h1>
	<table cellspacing=1 width=600 border=1 align="center" text-align="center">
		<tr>
			<td width=100>일자</td>
			<td width=100>Suite</td>
			<td width=100>Superior</td>
			<td width=100>Standard</td>
		</tr>
		
<%
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.20:33060/reservation", "root", "kopoctc");
		Statement stmt = conn.createStatement();
		ResultSet rset;
		String reservable1 = "<a href='./Reservation.jsp'>예약가능</a>";
		String reservable2 = "<a href='./Reservation.jsp'>예약가능</a>";
		String reservable3 = "<a href='./Reservation.jsp'>예약가능</a>";
		
		Date time = new Date();
		Calendar cal = Calendar.getInstance();
		
		cal.setTime(new Date());
		SimpleDateFormat sf =new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sf2 =new SimpleDateFormat("(E)");
		
		reservable1 = "<a href='./Reservation.jsp?date_key=" + sf.format(cal.getTime()) + "&room_key=1'>예약가능</a>";
		reservable2 = "<a href='./Reservation.jsp?date_key=" + sf.format(cal.getTime()) + "&room_key=2'>예약가능</a>";
		reservable3 = "<a href='./Reservation.jsp?date_key=" + sf.format(cal.getTime()) + "&room_key=3'>예약가능</a>";
	
		rset = stmt.executeQuery("select name from reservation where reserve_date='" + sf.format(cal.getTime()) + "' and room=1;");
		if (!rset.isBeforeFirst() ) {    
		} else {
			while (rset.next()) {
				reservable1 = rset.getString(1);
			}
		}
		rset = stmt.executeQuery("select name from reservation where reserve_date='" + sf.format(cal.getTime()) + "' and room=2;");
		if (!rset.isBeforeFirst() ) {    
		} else {
			while (rset.next()) {
				reservable2 = rset.getString(1);
			}
		}
		rset = stmt.executeQuery("select name from reservation where reserve_date='" + sf.format(cal.getTime()) + "' and room=3;");
		if (!rset.isBeforeFirst() ) {    
		} else {
			while (rset.next()) {
				reservable3 = rset.getString(1);
			}
		}
%>
		<tr>
			<td width=100><%=sf.format(cal.getTime())%> <%= sf2.format(cal.getTime())%></td>
			<td width=100><%=reservable1%></td>
			<td width=100><%=reservable2%></td>
			<td width=100><%=reservable3%></td>
		</tr>
<%
		
		for (int i = 1; i < 30; i++) {
			cal.add(Calendar.DATE, 1);
			reservable1 = "<a href='./Reservation.jsp?date_key=" + sf.format(cal.getTime()) + "&room_key=1'>예약가능</a>";
			reservable2 = "<a href='./Reservation.jsp?date_key=" + sf.format(cal.getTime()) + "&room_key=2'>예약가능</a>";
			reservable3 = "<a href='./Reservation.jsp?date_key=" + sf.format(cal.getTime()) + "&room_key=3'>예약가능</a>";
			
			rset = stmt.executeQuery("select name from reservation where reserve_date='" + sf.format(cal.getTime()) + "' and room=1;");
			if (!rset.isBeforeFirst() ) {    
			} else {
				while (rset.next()) {
					reservable1 = rset.getString(1);
				}
			}
			rset = stmt.executeQuery("select name from reservation where reserve_date='" + sf.format(cal.getTime()) + "' and room=2;");
			if (!rset.isBeforeFirst() ) {    
			} else {
				while (rset.next()) {
					reservable2 = rset.getString(1);
				}
			}
			rset = stmt.executeQuery("select name from reservation where reserve_date='" + sf.format(cal.getTime()) + "' and room=3;");
			if (!rset.isBeforeFirst() ) {    
			} else {
				while (rset.next()) {
					reservable3 = rset.getString(1);
				}
			}
%>
		<tr>
			<td width=100><%=sf.format(cal.getTime())%> <%= sf2.format(cal.getTime())%></td>
			<td width=100><%=reservable1%></td>
			<td width=100><%=reservable2%></td>
			<td width=100><%=reservable3%></td>
		</tr>
<%
		}
		
		rset.close();	
		stmt.close();	
		conn.close();	
		
	} catch (SQLSyntaxErrorException se) {
		out.println(se);
	} catch (Exception e) {
		out.println(e);
	}
%>
	</table>
</body>
</html>
