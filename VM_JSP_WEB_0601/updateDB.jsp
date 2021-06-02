<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateDB</title>
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
		
		String id = request.getParameter("studentid");
		String strname = request.getParameter("name");
		String strkor = request.getParameter("kor");
		String streng = request.getParameter("eng");
		String strmat = request.getParameter("mat");
		
		if (strname.length() == 0 || id.length()==0 || strkor.length()==0 || streng.length()==0 || strmat.length()==0) {			
			out.println("기입 항목을 다시 한 번 확인해 주십시오.<br>");
			out.println("숫자가 아닌 수를 기입하셨는지 혹은 공란이 존재하는지 확인 바랍니다.<br>");
			return;
		}
		
		
		
		out.println("<h1>레코드 수정</h1>");
		
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
		
		if (kor < 0) {
			kor = 0;
			out.println("국어에 0점 미만의 점수를 입력하셨습니다.<br>0점으로 처리됩니다.<br><br>");
		}
		if (eng < 0) {
			eng = 0;
			out.println("영어에 0점 미만의 점수를 입력하셨습니다.<br>0점으로 처리됩니다.<br><br>");
		}
		if (mat < 0) {
			mat = 0;
			out.println("수학에 0점 미만의 점수를 입력하셨습니다.<br>0점으로 처리됩니다.<br><br>");
		}
		
		stmt.execute("update examtable set name='" + strname + "', kor=" + kor + ", eng=" + eng + ", mat=" + mat + " where id=" + id + ";");
		String QueryTxt = String.format("select * from examtable;");
		ResultSet rset = stmt.executeQuery(QueryTxt);

		
		out.println("<table>");
		
		out.println("<tr>");
		out.println("<td width=50><p align=center>이름</p></td>");
		out.println("<td width=50><p align=center>학번</p></td>");
		out.println("<td width=50><p align=center>국어</p></td>");
		out.println("<td width=50><p align=center>영어</p></td>");
		out.println("<td width=50><p align=center>수학</p></td>");
		out.println("</tr>");

		while (rset.next()) {
			
			if (rset.getInt(2) == Integer.parseInt(id)) {
				out.println("<tr style='background-color:yellow'>");
				out.println("<td width=50><p align=center>" + strname + "</p></td>");
				out.println("<td width=50><p align=center><a name='studentid' href='./OneviewDB.jsp?id=" + id + "' target=_self type='submit'>" + id + "</a></p></td>");
				out.println("<td width=50><p align=center>" + kor + "</p></td>");
				out.println("<td width=50><p align=center>" + eng + "</p></td>");
				out.println("<td width=50><p align=center>" + mat + "</p></td>");
				out.println("</tr>");
				continue;	
			} 
			
			out.println("<tr>");
			out.println("<td width=50><p align=center>" + rset.getString(1) + "</p></td>");
			out.println("<td width=50><p align=center><a name='studentid' href='./OneviewDB.jsp?id=" + Integer.toString(rset.getInt(2)) + "' target=_self type='submit'>" + Integer.toString(rset.getInt(2)) + "</a></p></td>");
			out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(3)) + "</p></td>");
			out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(4)) + "</p></td>");
			out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(5)) + "</p></td>");
			out.println("</tr>");	
		}
		
		out.println("</table>");
		
		rset.close();
		stmt.close();
		conn.close();
		
	} catch (SQLSyntaxErrorException se) {
		out.println("TABLE이 없습니다. 생성 후 넣어 주십시오.");
	} catch (SQLIntegrityConstraintViolationException ve) {
		out.println("이미 지정되어 있는 학번입니다.<br>");
		out.println("다른 학번으로 지정해 주십시오.");
	} catch (NumberFormatException nfe) {
		out.println("기입 항목을 다시 한 번 확인해 주십시오.<br>");
		out.println("숫자가 아닌 수를 기입하셨는지 혹은 공란이 존재하는지 확인 바랍니다..<br>");
	} catch (Exception e) {
		out.println("모든 항목을 기입해 주십시오");
	}
%>
</body>
</html>