<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>showREC</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	function submit2(frm) {
		frm.action='./deleteDB.jsp';
		frm.method='get';
		frm.target='main3';
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
<script>

			
	 // 특수문자 정규식 변수(공백 미포함)
    var replaceChar = /[~!@\#$%^&*\()\-=+_'\;<>0-9\/.\`:\"\\,\[\]?|{}]/gi;
 
    // 완성형 아닌 한글 정규식
    var replaceNotFullKorean = /[ㄱ-ㅎㅏ-ㅣ]/gi;
    
    $(document).ready(function(){
        
        $("#inputid").on("focusout", function() {
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
		
		String QueryTxt = String.format("select * from examtable where id=" + id + ";");
		ResultSet rset = stmt.executeQuery(QueryTxt);
		
		if (!rset.isBeforeFirst() ) {    
			out.println("입력하신 학번에 해당하는 데이터가 없습니다.<br>"); 
			out.println("좌측의 탭을 이용해 자료를 넣어주십시오."); 
			return;
		}
		
		out.println("<form action='./updateDB.jsp' method='get' target='main3'>");

		while (rset.next()) {
			out.println("<table>");
			
			out.println("<tr>");
			out.println("<td width=50><p align=center>이름</p></td>");
			out.println("<td width=50><p align=center><input type='text' name='name' id='inputid' onkeyup='onlyKorean(this.value)' value='" + rset.getString(1) + "'></p></td>");
			out.println("</tr>");
			
			out.println("<tr>");
			out.println("<td width=50><p align=center>학번</p></td>");
			out.println("<td width=50><p align=center><input type='text' name='studentid' value='" + Integer.toString(rset.getInt(2)) + "' readonly></p></td>");
			out.println("</tr>");
			
			out.println("<tr>");
			out.println("<td width=50><p align=center>국어</p></td>");
			out.println("<td width=50><p align=center><input type='text' name='kor' value='" + Integer.toString(rset.getInt(3)) + "'></p></td>");
			out.println("</tr>");
			
			out.println("<tr>");
			out.println("<td width=50><p align=center>영어</p></td>");
			out.println("<td width=50><p align=center><input type='text' name='eng' value='" + Integer.toString(rset.getInt(4)) + "'></p></td>");
			out.println("</tr>");
			
			out.println("<tr>");
			out.println("<td width=50><p align=center>수학</p></td>");
			out.println("<td width=50><p align=center><input type='text' name='mat' value='" + Integer.toString(rset.getInt(5)) + "'></p></td>");
			out.println("</tr>");
			
			out.println("</table>");
		}
		
		out.println("<input type='submit' value='정정'>");
		out.println("<input type='button' value='삭제' onclick='return submit2(this.form);'>");
		out.println("</form>");

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