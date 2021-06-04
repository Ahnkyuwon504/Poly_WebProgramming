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
	
	tr {
		border-bottom: 1px solid black;
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
				<td width=420><p>
					<form id='onehubo<%=rset.getInt(1)%>' action='./C02.jsp' method='post' target='main'>
					<input type='hidden' name='kiho_key' value='<%=rset.getInt(1)%>'/>
					</form>
					<%=rset.getInt(1)%>번 <a href='javascript:$("#onehubo<%=rset.getInt(1)%>").submit()'><%=rset.getString(2)%></a>
				</p></td>
				<td style='border-left: 1px solid black'><p>0(0%)</p></td>
				</tr>
<%	
				count++;
				}
			}
			else {
				
				while(rset.next()) {
					int redboxsize = 4 *rset.getInt(4);
%>
		<tr>
			<td width=420><p>
				<form id='onehubo<%=rset.getInt(1)%>' action='./C02.jsp' method='post' target='main'>
				<input type='hidden' name='kiho_key' value='<%=rset.getInt(1)%>'/>
				</form>
				<%=rset.getInt(1)%>번 <a href='javascript:$("#onehubo<%=rset.getInt(1)%>").submit()'><%=rset.getString(2)%></a>
			</p></td>
			<td style='border-left: 1px solid black'><p><img src='./red.png' height=20px width=<%=redboxsize%>px>&nbsp;<%=rset.getInt(3)%>(<%=rset.getInt(4)%>%)</p></td>
		</tr>
<%
				}
			}
		}
		
		rset.close();
		stmt.close();
		conn.close();
	} catch (Exception e) {
		out.println("모든 항목을 기입해 주십시오");
	}
%>
</table>
</body>
</html>