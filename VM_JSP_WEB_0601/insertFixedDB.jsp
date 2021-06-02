<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertFixedDB</title>
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
		String QueryTxt5 = String.format("select max(id) from examtable;");
		ResultSet rset5 = stmt.executeQuery(QueryTxt5);
		
		String strid5;
		
		int count5 = 0;
		
		while (rset5.next()) {
			count5 = rset5.getInt(1) + 1;
		}
			
		count5 -= 209900;
		
			
		String QueryTxt2 = String.format("select count(*) from examtable;");
		ResultSet rset2 = stmt.executeQuery(QueryTxt2);
		
		String strid2;
		
		int count = 0;
		
		while (rset2.next()) {
			count = rset2.getInt(1) + 1;
		}
			
		if (count5 > count) {
			count = count5;
		}
		
		if (count < 10) {
			strid2 = "20990" + count;
		} else {
			strid2 = "2099" + count;
		}
		
		int studentid = Integer.parseInt(strid2);
		
		
		PrintWriter pw = response.getWriter();
		
		request.setCharacterEncoding("utf-8");
		
		stmt.execute("insert into examtable (name, id, kor, eng, mat) values ('효민', " + studentid + ", 95, 100, 95);");
		stmt.execute("insert into examtable (name, id, kor, eng, mat) values ('보람', " + (studentid + 1) + ", 100, 80, 75);");
		stmt.execute("insert into examtable (name, id, kor, eng, mat) values ('은정', " + (studentid + 2) + ", 95, 50, 0);");
		stmt.execute("insert into examtable (name, id, kor, eng, mat) values ('지연', " + (studentid + 3) + ", 40, 100, 95);");
		stmt.execute("insert into examtable (name, id, kor, eng, mat) values ('소연', " + (studentid + 4) + ", 95, 50, 95);");
		stmt.execute("insert into examtable (name, id, kor, eng, mat) values ('큐리', " + (studentid + 5) + ", 95, 60, 95);");
		stmt.execute("insert into examtable (name, id, kor, eng, mat) values ('화영', " + (studentid + 6) + ", 95, 80, 95);");

		stmt.close();
		conn.close();
		
		out.println("<h1>티아라 멤버 7명이<br>TABLE에 추가되었습니다.</h1>");
	} catch (SQLSyntaxErrorException se) {
		out.println("TABLE이 없습니다. 생성 후 넣어 주십시오.");
	} catch (SQLIntegrityConstraintViolationException ve) {
		out.println("<h1>이미 티아라 멤버는 추가되어 있습니다.</h1><br>");
		out.println("<h1>좌측의 탭을 참조하여 TABLE 삭제<br>혹은 새로운 값을 추가해주십시오.</h1>");
	} catch (NumberFormatException nfe) {
		out.println("기입 항목을 다시 한 번 확인해 주십시오.<br>");
		out.println("숫자가 아닌 수를 기입하셨는지 혹은 공란이 존재하는지 확인 바랍니다..<br>");
	} catch (Exception e) {
		out.println("모든 항목을 기입해 주십시오");
		out.println(e);
	}
%>
</body>
</html>