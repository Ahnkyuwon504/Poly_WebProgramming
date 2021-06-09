<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ReservationStatus</title>
</head>
<body>
헤헤헤
	<%
	try {
      
      out.print("히히2");
	    Class.forName("com.mysql.cj.jdbc.Driver");
      out.print("히히2");
		// 드라이버에 연결
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.20:33060/kopoctc_HW4", "root", "kopoctc");
      out.print("히히3");
		// 다이렉트로 꽂는다...
		Statement stmt = conn.createStatement();
      out.print("히히4");
		// stmt에 String 넣어서 실행시킬 거다...
	    ResultSet rset = stmt.executeQuery("select * from reservation;");
      out.print("히히");
		// 테이블 만들기...
    
        while (rset.next()) {
            out.println(rset.getString(1));
        }
    
    
    
        rset.close();
		stmt.close(); // 끝났으면 닫아 주자..
		conn.close(); // 끝났으면 닫아 주자..
    
		request.setCharacterEncoding("utf-8");

		
	
	} catch (Exception e) {
		out.println(e + "<br>");
	} 
	%>

	












</body>
</html>