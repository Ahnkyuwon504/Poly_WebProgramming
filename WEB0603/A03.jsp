<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>A03</title>
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
		out.println("<h1>후보등록 결과</h1><br>");
		request.setCharacterEncoding("utf-8");
		
		String id = request.getParameter("kiho_insert_key");
		String name = request.getParameter("name_insert_key");
		
		if (name == null || name.length() == 0) {
			out.println("기호 혹은 이름에 공란이 존재하는지 확인 후 재생성 바랍니다.");
			return;
		}
		
		if (Integer.parseInt(id) == 0) {
			out.println("기호는 1번부터 가능합니다. 재생성 바랍니다.");
			return;
		}
		
		stmt.execute("insert hubo (kiho, name) values (" + id + ", '" + name + "');");
		
		stmt.close();
		conn.close();
		
		out.println(id + "번 " + name + "후보 추가 완료");
	} catch (SQLSyntaxErrorException se) {
		out.println("기호 혹은 이름에 공란이 존재하는지 확인 후 재생성 바랍니다.");
	} catch (SQLIntegrityConstraintViolationException ve) {
		out.println("이미 지정되어 있는 기호입니다.<br>");
		out.println("다른 기호로 지정해 주십시오.");
	} catch (NumberFormatException nfe) {
		out.println("21억 4748만 3647 이하의 기호만 입력 가능합니다.<br>");
		out.println("후보번호를 낮추셔서 재생성 바랍니다.<br>");
	} catch (Exception e) {
		out.println("너무 긴 이름을 입력하셨습니다. 재생성 바랍니다.");
	}
%>
</body>
</html>