<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>C01</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style>
table {
	border: 1px solid black;
	border-collapse: collapse;
	width : 100%;
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
<h1>후보 별 득표율</h1><br>
<%
	try {
		String kiho = request.getParameter("kiho_key");
		out.println(kiho);

		
		request.setCharacterEncoding("utf-8");
		String QueryTxt;
		ResultSet rset;
		
		QueryTxt = "select age, count(age)/(select count(*) from tupyo where kiho=" + kiho + ") from tupyo where kiho=" + kiho + " group by age;";
		rset = stmt.executeQuery(QueryTxt);
		
		if (!rset.isBeforeFirst() ) {    
			out.println("아직 등록된 후보가 없거나, 또는 투표가 실시되지 않았습니다.<br>"); 
			out.println("상단의 탭을 참조하십시오."); 
			return;
		}
		
		







		
		QueryTxt = " select a.kiho, b.name, count(a.kiho), count(a.kiho)*100/(select count(*) from tupyo)" +
						  " from tupyo as a, hubo as b where a.kiho=b.kiho group by a.kiho;";
		
		rset = stmt.executeQuery(QueryTxt);
		
		if (!rset.isBeforeFirst() ) {    
			out.println("아직 등록된 후보가 없거나, 또는 투표가 실시되지 않았습니다.<br>"); 
			out.println("상단의 탭을 참조하십시오."); 
			return;
		}
%>
<table>
<%
		int nullcnt = 0;
	
		while (rset.next()) {
%>
		<tr>
			<td width=50><p align=center>기호번호 : <%=rset.getInt(1)%></p></td>
			<td width=50><p align=center>
				<form id='onehubo<%=rset.getInt(1)%>' action='./C02.jsp' method='post' target='main'>
				<input type='hidden' name='kiho_key' value='<%=rset.getInt(1)%>'/>
				</form>
				<a href='javascript:$("#onehubo<%=rset.getInt(1)%>").submit()'>후보명 : <%=rset.getString(2)%></a>
			</p></td>
			<td width=50><p align=center>득표율 : <%=rset.getInt(3)%>(<%=rset.getInt(4)%>%)</p></td>
		</tr>
<%
		}
		
		
		
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
</table>
</body>
</html>