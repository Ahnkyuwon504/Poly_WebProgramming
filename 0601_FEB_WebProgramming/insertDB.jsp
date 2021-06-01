<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertDB</title>
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
		request.setCharacterEncoding("utf-8");
		PrintWriter pw = response.getWriter();
		
		String name = request.getParameter("name");
		String strid = request.getParameter("id");
		String strkor = request.getParameter("kor");
		String streng = request.getParameter("eng");
		String strmat = request.getParameter("mat"); 
		
		
		if (strid==null && name==null && strkor==null && streng==null && strmat==null) {
			out.println("<form action='./insertDB.jsp' method='get' target='main2'>");
			out.println("이름&nbsp;<input type='text' name='name'><br>");
			out.println("학번&nbsp;<input type='text' name='id'><br>");
			out.println("국어&nbsp;<input type='text' name='kor'><br>");
			out.println("영어&nbsp;<input type='text' name='eng'><br>");
			out.println("수학&nbsp;<input type='text' name='mat'><br><br>");
			out.println("&nbsp;&nbsp;&nbsp;<input type='submit' value='데이터 세팅'>");
			out.println("</form>");
			return;
		}
		
		if (name.length() == 0 || strid==null || name==null || strkor==null || streng==null || strmat==null) {			
			out.println("<form action='./insertDB.jsp' method='get' target='main2'>");
			out.println("이름&nbsp;<input type='text' name='name' placeholder='" + name + "'><br>");
			out.println("학번&nbsp;<input type='text' name='id' placeholder='" + strid + "'><br>");
			out.println("국어&nbsp;<input type='text' name='kor' placeholder='" + strkor + "'><br>");
			out.println("영어&nbsp;<input type='text' name='eng' placeholder='" + streng + "'><br>");
			out.println("수학&nbsp;<input type='text' name='mat' placeholder='" + strmat + "'><br><br>");
			out.println("&nbsp;&nbsp;&nbsp;<input type='submit' value='데이터 세팅'><br><br>");
			out.println("</form>");
			out.println("기입 항목을 다시 한 번 확인해 주십시오.<br>");
			out.println("숫자가 아닌 수를 기입하셨는지 혹은 공란이 존재하는지 확인 바랍니다.<br>");
			return;
		}
		
		
		
		int id = Integer.parseInt(strid);
		int kor = Integer.parseInt(strkor);
		int eng = Integer.parseInt(streng);
		int mat = Integer.parseInt(strmat);
		
		
		
		if (kor > 100) {
			kor = 100;
			out.println("국어점수에 100점을 넘는 점수를 입력하셨습니다.<br>");
			out.println("100점으로 처리됩니다.<br><br>");
		}
		if (eng > 100) {
			eng = 100;
			out.println("영어점수에 100점을 넘는 점수를 입력하셨습니다.<br>");
			out.println("100점으로 처리됩니다.<br><br>");
		}
		if (mat > 100) {
			mat = 100;
			out.println("수학점수에 100점을 넘는 점수를 입력하셨습니다.<br>");
			out.println("100점으로 처리됩니다.<br><br>");
		}
		

		
		String QueryTxt;
		
		QueryTxt = String.format(
			"insert into examtable (name, id, kor, eng, mat) values ('%s', %d, %d, %d, %d);", name, id, kor, eng, mat);
		stmt.execute(QueryTxt);
		
		out.println("<form action='./insertDB.jsp' method='get' target='main2'>");
		out.println("이름&nbsp;<input type='text' name='name' placeholder='" + name + "'><br>");
		out.println("학번&nbsp;<input type='text' name='id' placeholder='" + id + "'><br>");
		out.println("국어&nbsp;<input type='text' name='kor' placeholder='" + kor + "'><br>");
		out.println("영어&nbsp;<input type='text' name='eng' placeholder='" + eng + "'><br>");
		out.println("수학&nbsp;<input type='text' name='mat' placeholder='" + mat + "'><br><br>");
		out.println("&nbsp;&nbsp;&nbsp;<input type='submit' value='데이터 세팅'>");
		out.println("</form>");
		out.println("입력하신 데이터가 세팅되었습니다.<br>");

		stmt.close();
		conn.close();
		
	} catch (SQLSyntaxErrorException se) {
		out.println("<form action='./insertDB.jsp' method='get' target='main2'>");
		out.println("이름&nbsp;<input type='text' name='name'><br>");
		out.println("학번&nbsp;<input type='text' name='id'><br>");
		out.println("국어&nbsp;<input type='text' name='kor'><br>");
		out.println("영어&nbsp;<input type='text' name='eng'><br>");
		out.println("수학&nbsp;<input type='text' name='mat'><br><br>");
		out.println("&nbsp;&nbsp;&nbsp;<input type='submit' value='데이터 세팅'>");
		out.println("</form>");
		out.println("TABLE이 없습니다. 생성 후 넣어 주십시오.");
	} catch (SQLIntegrityConstraintViolationException ve) {
		out.println("<form action='./insertDB.jsp' method='get' target='main2'>");
		out.println("이름&nbsp;<input type='text' name='name'><br>");
		out.println("학번&nbsp;<input type='text' name='id'><br>");
		out.println("국어&nbsp;<input type='text' name='kor'><br>");
		out.println("영어&nbsp;<input type='text' name='eng'><br>");
		out.println("수학&nbsp;<input type='text' name='mat'><br><br>");
		out.println("&nbsp;&nbsp;&nbsp;<input type='submit' value='데이터 세팅'>");
		out.println("</form>");
		out.println("이미 지정되어 있는 학번입니다.<br>");
		out.println("다른 학번으로 지정해 주십시오.");
	} catch (NumberFormatException nfe) {
		out.println("<form action='./insertDB.jsp' method='get' target='main2'>");
		out.println("이름&nbsp;<input type='text' name='name'><br>");
		out.println("학번&nbsp;<input type='text' name='id'><br>");
		out.println("국어&nbsp;<input type='text' name='kor'><br>");
		out.println("영어&nbsp;<input type='text' name='eng'><br>");
		out.println("수학&nbsp;<input type='text' name='mat'><br><br>");
		out.println("&nbsp;&nbsp;&nbsp;<input type='submit' value='데이터 세팅'>");
		out.println("</form>");
		out.println("기입 항목을 다시 한 번 확인해 주십시오.<br>");
		out.println("숫자가 아닌 수를 기입하셨는지 혹은 공란이 존재하는지 확인 바랍니다..<br>");
	} catch (Exception e) {
		out.println("<form action='./insertDB.jsp' method='get' target='main2'>");
		out.println("이름&nbsp;<input type='text' name='name'><br>");
		out.println("학번&nbsp;<input type='text' name='id'><br>");
		out.println("국어&nbsp;<input type='text' name='kor'><br>");
		out.println("영어&nbsp;<input type='text' name='eng'><br>");
		out.println("수학&nbsp;<input type='text' name='mat'><br><br>");
		out.println("&nbsp;&nbsp;&nbsp;<input type='submit' value='데이터 세팅'>");
		out.println("</form>");
		out.println("모든 항목을 기입해 주십시오");
		out.println(e);
	}
%>
</body>
</html>