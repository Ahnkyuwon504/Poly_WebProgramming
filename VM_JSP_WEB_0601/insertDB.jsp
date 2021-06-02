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
		
		String name = request.getParameter("name");
		String strid = request.getParameter("id");
		String strkor = request.getParameter("kor");
		String streng = request.getParameter("eng");
		String strmat = request.getParameter("mat"); 
		
		if (strid==null && name==null && strkor==null && streng==null && strmat==null) {
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
			out.println("<form action='./insertDB.jsp' method='get' target='main3'>");
			out.println("이름&nbsp;<input type='text' name='name' value='' id='inputid' onkeyup='onlyKorean(this.value)'><br>");
			out.println("학번&nbsp;<input type='text' name='id' value='" + strid2 + "' readonly>&nbsp; 자동부여됩니다.<br>");
			out.println("국어&nbsp;<input type='text' name='kor'><br>");
			out.println("영어&nbsp;<input type='text' name='eng'><br>");
			out.println("수학&nbsp;<input type='text' name='mat'><br><br>");
			out.println("&nbsp;&nbsp;&nbsp;<input type='submit' value='데이터 세팅'>");
			out.println("</form>");
			
			return;
		}
		
		if (name.length() == 0 || strid==null || name==null || strkor==null || streng==null || strmat==null) {			
			out.println("<form action='./insertDB.jsp' method='get' target='main3'>");
			out.println("이름&nbsp;<input type='text' name='name' id='inputname' id='inputid' onkeyup='onlyKorean(this.value)' placeholder='" + name + "'><br>");
			out.println("학번&nbsp;<input type='text' name='id'  placeholder='" + strid + "'><br>");
			out.println("국어&nbsp;<input type='text' name='kor' placeholder='" + strkor + "'><br>");
			out.println("영어&nbsp;<input type='text' name='eng' placeholder='" + streng + "'><br>");
			out.println("수학&nbsp;<input type='text' name='mat' placeholder='" + strmat + "'><br><br>");
			out.println("&nbsp;&nbsp;&nbsp;<input type='submit' value='데이터 세팅'><br><br>");
			out.println("</form>");
			out.println("기입 항목을 다시 한 번 확인해 주십시오.<br>");
			out.println("숫자가 아닌 수를 기입하셨는지 혹은 공란이 존재하는지 확인 바랍니다.<br>");
			return;
		}
		
		String QueryTxt3 = String.format("select count(*) from examtable;");
			ResultSet rset3 = stmt.executeQuery(QueryTxt3);
			String strid3;
		
			int count3 = 0;
		
			while (rset3.next()) {
				count3 = rset3.getInt(1) + 1;
			}
			
			String QueryTxt6 = String.format("select max(id) from examtable;");
			ResultSet rset6 = stmt.executeQuery(QueryTxt6);
		
			String strid6;
		
			int count6 = 0;
		
			while (rset6.next()) {
				count6 = rset6.getInt(1) + 1;
			}
			
			count6 -= 209900;
			
			if (count6 > count3) {
				count3 = count6;
			}
		
			if (count3 < 10) {
				strid3 = "20990" + count3;
			} else {
				strid3 = "2099" + count3;
			}
			
		if (strid != strid3) {
			
			strid = strid3;
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
		String QueryTxt;
		
		QueryTxt = String.format(
			"insert into examtable (name, id, kor, eng, mat) values ('%s', %s, %d, %d, %d);", name, strid, kor, eng, mat);
		stmt.execute(QueryTxt);
		
		out.println("<form action='./insertDB.jsp' method='get' target='main3'>");
		out.println("이름&nbsp;<input type='text' name='name' id='inputid' onkeyup='onlyKorean(this.value)' placeholder='" + name + "'><br>");
		out.println("학번&nbsp;<input type='text' name='id'  value='" + (Integer.parseInt(strid3) + 1) + "' readonly> 자동부여됩니다.<br>");
		out.println("국어&nbsp;<input type='text' name='kor' placeholder='" + kor + "'><br>");
		out.println("영어&nbsp;<input type='text' name='eng' placeholder='" + eng + "'><br>");
		out.println("수학&nbsp;<input type='text' name='mat' placeholder='" + mat + "'><br><br>");
		out.println("&nbsp;&nbsp;&nbsp;<input type='submit' value='데이터 세팅'>");
		out.println("</form>");
		out.println("입력하신 데이터가 세팅되었습니다.<br>");

		stmt.close();
		conn.close();
		
	}
	 catch (SQLSyntaxErrorException se) {
		 out.println("TABLE이 존재하지 않습니다.<br>좌측의 탭을 참조하여 생성 후 추가해주십시오.");

	} catch (SQLIntegrityConstraintViolationException ve) {
				String QueryTxt3 = String.format("select count(*) from examtable;");
			ResultSet rset3 = stmt.executeQuery(QueryTxt3);
			String strid3;
		
			int count3 = 0;
		
			while (rset3.next()) {
				count3 = rset3.getInt(1);
			}
			
			String QueryTxt6 = String.format("select max(id) from examtable;");
			ResultSet rset6 = stmt.executeQuery(QueryTxt6);
		
			String strid6;
		
			int count6 = 0;
		
			while (rset6.next()) {
				count6 = rset6.getInt(1);
			}
			
			count6 -= 209900;
			
			if (count6 > count3) {
				count3 = count6;
			}
		
			if (count3 < 10) {
				strid3 = "20990" + count3;
			} else {
				strid3 = "2099" + count3;
			}
		out.println("<form action='./insertDB.jsp' method='get' target='main3'>");
		out.println("이름&nbsp;<input type='text' name='name'  id='inputid' onkeyup='onlyKorean(this.value)'><br>");
		out.println("학번&nbsp;<input type='text' name='id'  value='" + (Integer.parseInt(strid3) + 1) + "' readonly> 자동부여됩니다.<br>");
		out.println("국어&nbsp;<input type='text' name='kor'><br>");
		out.println("영어&nbsp;<input type='text' name='eng'><br>");
		out.println("수학&nbsp;<input type='text' name='mat'><br><br>");
		out.println("&nbsp;&nbsp;&nbsp;<input type='submit' value='데이터 세팅'>");
		out.println("</form>");
		out.println("이미 지정되어 있는 학번입니다.<br>");
		out.println("다른 학번으로 지정해 주십시오.");
	} catch (NumberFormatException nfe) {
				String QueryTxt3 = String.format("select count(*) from examtable;");
			ResultSet rset3 = stmt.executeQuery(QueryTxt3);
			String strid3;
		
			int count3 = 0;
		
			while (rset3.next()) {
				count3 = rset3.getInt(1);
			}
			
			String QueryTxt6 = String.format("select max(id) from examtable;");
			ResultSet rset6 = stmt.executeQuery(QueryTxt6);
		
			String strid6;
		
			int count6 = 0;
		
			while (rset6.next()) {
				count6 = rset6.getInt(1);
			}
			
			count6 -= 209900;
			
			if (count6 > count3) {
				count3 = count6;
			}
		
			if (count3 < 10) {
				strid3 = "20990" + count3;
			} else {
				strid3 = "2099" + count3;
			}
		out.println("<form action='./insertDB.jsp' method='get' target='main3'>");
		out.println("이름&nbsp;<input type='text' name='name'  id='inputid' onkeyup='onlyKorean(this.value)'><br>");
		out.println("학번&nbsp;<input type='text' name='id'  value='" + (Integer.parseInt(strid3) + 1) + "' readonly> 자동부여됩니다.<br>");
		out.println("국어&nbsp;<input type='text' name='kor'><br>");
		out.println("영어&nbsp;<input type='text' name='eng'><br>");
		out.println("수학&nbsp;<input type='text' name='mat'><br><br>");
		out.println("&nbsp;&nbsp;&nbsp;<input type='submit' value='데이터 세팅'>");
		out.println("</form>");
		out.println("기입 항목을 다시 한 번 확인해 주십시오.<br>");
		out.println("숫자가 아닌 수를 기입하셨는지 혹은 공란이 존재하는지 확인 바랍니다..<br>");
	} catch (Exception e) {
				String QueryTxt3 = String.format("select count(*) from examtable;");
			ResultSet rset3 = stmt.executeQuery(QueryTxt3);
			String strid3;
		
			int count3 = 0;
		
			while (rset3.next()) {
				count3 = rset3.getInt(1);
			}
			
			String QueryTxt6 = String.format("select max(id) from examtable;");
			ResultSet rset6 = stmt.executeQuery(QueryTxt6);
		
			String strid6;
		
			int count6 = 0;
		
			while (rset6.next()) {
				count6 = rset6.getInt(1);
			}
			
			count6 -= 209900;
			
			if (count6 > count3) {
				count3 = count6;
			}
		
			if (count3 < 10) {
				strid3 = "20990" + count3;
			} else {
				strid3 = "2099" + count3;
			}
		out.println("<form action='./insertDB.jsp' method='get' target='main3'>");
		out.println("이름&nbsp;<input type='text' name='name' id='inputid' onkeyup='onlyKorean(this.value)'><br>");
		out.println("학번&nbsp;<input type='text' name='id'  value='" + (Integer.parseInt(strid3) + 1) + "' readonly> 자동부여됩니다.<br>");
		out.println("국어&nbsp;<input type='text' name='kor'><br>");
		out.println("영어&nbsp;<input type='text' name='eng'><br>");
		out.println("수학&nbsp;<input type='text' name='mat'><br><br>");
		out.println("&nbsp;&nbsp;&nbsp;<input type='submit' value='데이터 세팅'>");
		out.println("</form>");
		out.println("너무 긴 이름을 입력하셨습니다.<br>재입력 바랍니다.");
	}
%>
</body>
</html>