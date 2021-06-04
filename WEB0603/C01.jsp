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
		request.setCharacterEncoding("utf-8");
		String QueryTxt;
		ResultSet rset;
		
		ArrayList<Integer> kihoArrayList = new ArrayList<Integer>();
		ArrayList<Integer> nullHuboArrayList = new ArrayList<Integer>();
		
		QueryTxt = "select kiho from hubo;";
		rset = stmt.executeQuery(QueryTxt);
		
		if (!rset.isBeforeFirst() ) {    
			out.println("아직 등록된 후보가 없습니다.<br>"); 
			out.println("상단의 탭을 참조해 후보를 등록해 주십시오."); 
			return;
		}
		
		while (rset.next()) {
			kihoArrayList.add(rset.getInt(1));
		}
		
		if (kihoArrayList.size() == 1) {
%>
현재 단일후보입니다.<br>
<%			
		}
		
		for (int i = 0 ; i < kihoArrayList.size(); i++) {
			
			QueryTxt = "select * from tupyo where kiho=" + kihoArrayList.get(i) + ";";
			rset = stmt.executeQuery(QueryTxt);
			
			if (!rset.isBeforeFirst() ) {    
				nullHuboArrayList.add(kihoArrayList.get(i));
			}
		}
		
		if (nullHuboArrayList.size() == kihoArrayList.size()) {
%>
실시된 투표가 0건입니다.<br><br>
<%			
		}
		
		int count = 0;
%>
<table>
<%
		for (int i = 0; i < kihoArrayList.size(); i++) {
			QueryTxt = " select a.kiho, b.name, count(a.kiho), count(a.kiho)*100/(select count(*) from tupyo)" +
						  " from tupyo as a, hubo as b where a.kiho=b.kiho and b.kiho=" + kihoArrayList.get(i) + " group by a.kiho;";
		
			rset = stmt.executeQuery(QueryTxt);
		
			if (!rset.isBeforeFirst() ) {
				QueryTxt = "select * from hubo where  kiho=" + 	nullHuboArrayList.get(count) + ";";
				rset = stmt.executeQuery(QueryTxt);
			
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
				<td width=50><p align=center>득표율 : 0(0%)</p></td>
				</tr>
<%	
				count++;
				}
			}
			else {
				
				while(rset.next()) {
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
			}
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
		out.println(e);
	}
%>
</table>
</body>
</html>