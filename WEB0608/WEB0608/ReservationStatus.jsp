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
<script>
	let today = new Date();
	
	let year = today.getFullYear();
	let month = today.getMonth() + 1;
	let date = today.getDate();
	let day = today.getDay();
	


	function submit2(frm) {
		frm.action='./A02.jsp';
		frm.method='post';
		frm.target='main';
		frm.submit();
		return true;
	}
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
<style>

</style>
</head>

<body>
	<h1>예약상황</h1>
	<table cellspacing=1 width=600 border=1>
		<tr>
			<td width=50>일자</td>
			<td width=50>Suite</td>
			<td width=50>Superior</td>
			<td width=50>Standard</td>
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
			<td width=50><%=sf.format(cal.getTime())%> <%= sf2.format(cal.getTime())%></td>
			<td width=50><%=reservable1%></td>
			<td width=50><%=reservable2%></td>
			<td width=50><%=reservable3%></td>
		</tr>
<%
		
		for (int i = 1; i < 12; i++) {
			reservable1 = "<a href='./Reservation.jsp'>예약가능</a>";
			reservable2 = "<a href='./Reservation.jsp'>예약가능</a>";
			reservable3 = "<a href='./Reservation.jsp'>예약가능</a>";
			cal.add(Calendar.DATE, 1);
			
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
			<td width=50><%=sf.format(cal.getTime())%> <%= sf2.format(cal.getTime())%></td>
			<td width=50><%=reservable1%></td>
			<td width=50><%=reservable2%></td>
			<td width=50><%=reservable3%></td>
		</tr>
<%
	}
		

	
	
	
	
	
	
	
	
	
	
	
	


	
		while (rset.next()) {

	

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

<%!
	public String getDateDay(String date, String dateType) throws Exception {
		
		return "";
	}


	%>
</body>
</html>