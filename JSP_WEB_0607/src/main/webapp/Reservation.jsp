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
<title>Reservation</title>
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
<script>
	 // 특수문자 정규식 변수(공백 미포함)
    var replaceChar = /[~!@\#$%^&*\()\-=+_'\;<>0-9\/.\`:\"\\,\[\]?|{}]/gi;
 
    // 완성형 아닌 한글 정규식
    var replaceNotFullKorean = /[ㄱ-ㅎㅏ-ㅣ]/gi;
    
    $(document).ready(function(){
        
        $("#name_key").on("focusout", function() {
            var x = $(this).val();
            if (x.length > 0) {
                if (x.match(replaceChar) || x.match(replaceNotFullKorean)) {
                    x = x.replace(replaceChar, "").replace(replaceNotFullKorean, "");
                }
                $(this).val(x);
            }
            }).on("keyup", function() {
                $(this).val($(this).val().replace(replaceChar, ""));
				
				  var a = $(this).val().replace(/ /gi, '');
				$(this).val(a);
		});
    }); 
</script>
</head>

<body align="center">
		
<%
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.20:33060/reservation", "root", "kopoctc");
		Statement stmt = conn.createStatement();
		
		String reserve_date = request.getParameter("date_key");
		String room = request.getParameter("room_key");
		String room_name;
		
		if (room.equals("1")) {
			room_name = "Suite";
		} else if (room.equals("2")) {
			room_name = "Superior";
		} else {
			room_name = "Standard";
		}
%>

	<h1>예약하기</h1>
	<form action='./Final2.jsp' method='post'>
		<table cellspacing=1 width=600 border=1  align="center">
			<tr>
				<td width=50><p align=center>성명</p></td>
				<td width=50><p align=center><input id='name_key' name='name_key' type='text'></p></td>
			</tr>
			<tr>
				<td width=50><p align=center>예약일자</p></td>
				<td width=50><p align=center><input  name='reserve_date_key' type='text' value='<%=reserve_date%>' readonly></p></td>
			</tr>
			<tr>
				<td width=50><p align=center>예약방</p></td>
				<td width=50><p align=center>
					<select name='room_key'>
						<option value='<%=room%>'><%=room_name%></option>
					</select>
				</p></td>
			</tr>
			<tr>
				<td width=50><p align=center>주소</p></td>
				<td width=50><p align=center><input  name='addr_key' type='text'></p></td>
			</tr>
			<tr>
				<td width=50><p align=center>전화번호</p></td>
				<td width=50><p align=center><input  name='tel_key' type='text'></p></td>
			</tr>
			<tr>
				<td width=50><p align=center>입금자명</p></td>
				<td width=50><p align=center><input  name='ipgum_name_key' type='text'></p></td>
			</tr>
			<tr>
				<td width=50><p align=center>남기실말</p></td>
				<td width=50><p align=center><input  name='memo_key' type='text'></p></td>
			</tr>
		</table>
		<br>
		<input type='submit' value='예약하기'>
	</form>

<%		
		stmt.close();
		conn.close();
	} catch (Exception e) {
		out.print(e);
	}
%>


		

</body>
</html>