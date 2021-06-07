<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WiFI</title>
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
	try {
		request.setCharacterEncoding("utf-8");

		double lat = 37.3860521;
		double lng = 127.1214038;
	
		BufferedReader reader = null;
		PrintWriter pw = response.getWriter();
		
		String from = request.getParameter("from");
		String cnt = request.getParameter("cnt");
		
		if (from == null || cnt == null) {
			from = "0";
			cnt = "10";
		}
		
		int fromnumber = Integer.parseInt(from);
		int cntnumber = Integer.parseInt(cnt);
		int totalCnt = 0;
		
		try {
			pw.print("<center>");
			pw.print("<h1>와이파이</h1><br>");
			String filePath = application.getRealPath("/WEB-INF/전국무료와이파이표준데이터1.txt");
			reader = new BufferedReader(new FileReader(filePath));
			int LineCnt = 0;
			
			String str = reader.readLine();
			String[] field_name = str.split("\t");
			
			pw.printf("<table>");
			pw.printf("<tr>");
			pw.printf("<td>%s</td>", "번호");
			pw.printf("<td>%s</td>", field_name[9]);
			pw.printf("<td>%s</td>", field_name[12]);
			pw.printf("<td>%s</td>", field_name[13]);
			pw.printf("<td>%s</td>", "거리");
			pw.printf("</tr>");

			
			while (true) {
				pw.printf("<tr>");
				str = reader.readLine();
				if (str == null) break;
				
				if (LineCnt < fromnumber) {
					totalCnt++;
					LineCnt++;
					continue;
				}
				if (LineCnt > fromnumber + cntnumber - 1) {
					totalCnt++;
					continue;
				}
				
				String[] field = str.split("\t");
				
				double dist;
				
				if (field[12].length() == 0 || field[13].length() == 0) {
					field[12] = "0";
					field[13] = "0";
					dist = 0;
				} else {
					dist = Math.sqrt( Math.pow( Double.parseDouble(field[12]) - lat, 2)
							+ Math.pow( Double.parseDouble(field[13]) - lng, 2));
				}
				
				
				
				pw.printf("<td>%d</td>", LineCnt);
				pw.printf("<td>%s</td>", field[9]);
				pw.printf("<td>%s</td>", field[12]);
				pw.printf("<td>%s</td>", field[13]);
				pw.printf("<td>%f</td>", dist);
				
	
				totalCnt++;
				LineCnt++;
				pw.printf("</tr>");
			}
			
			pw.printf("</table>");
			pw.print("</center>");
			
			
		} catch (FileNotFoundException fnfe) {
			out.println("파일이 존재하지 않습니다.");
		} catch (IOException ioe) {
			out.println("파일을 읽을수 없습니다.");
		} finally {
			try {
				reader.close();
			} catch (Exception e) {

			}
		}
	
		if (from == null || cnt == null) {
			fromnumber = 10;
			cntnumber = 10;
			}
	
		int pageMax = 0;
		int firstpagenumber = 1;
	
		pw.printf("<center>");
		pw.printf("<a href='WIFI.jsp?from=0&cnt=" + cntnumber + "'>처음 </a>");
	
		if (fromnumber <= 0) {
			pw.printf("<a href='WIFI.jsp?from=0&cnt=" + (cntnumber) + "'>이전 </a>");
		} else {
			pw.printf("<a href='WIFI.jsp?from=" + (fromnumber - cntnumber) + "&cnt=" + (cntnumber) + "'>이전 </a>");
		
		}
	
		firstpagenumber = fromnumber / (cntnumber * 10) + 1;
		printpage(totalCnt, cntnumber, response, (fromnumber / (cntnumber * 10)) * 10 + 1);
	
		if (fromnumber >= (totalCnt / cntnumber) * cntnumber) {
			pw.printf("<a href='WIFI.jsp?from=" + ((totalCnt / cntnumber) * cntnumber) + "&cnt=" + (cntnumber) + "'> 이후 </a>");
		} else {
			pw.printf("<a href='WIFI.jsp?from=" + (fromnumber + cntnumber) + "&cnt=" + (cntnumber) + "'> 이후 </a>");
		}
	
		pw.printf("<a href='WIFI.jsp?from=" + (totalCnt / cntnumber) * cntnumber +"&cnt=" + cntnumber+"'> 끝</a>");
		pw.printf("</center>");
	
	} catch (ArithmeticException e1) {
		out.println(e1 + "<br>");
		out.println("<h1>굳이 0개를 입력하다니..창의력대장이다..</h1>");
	}
	
	catch (Exception e) {
		out.println(e + "<br>");
		out.println("<h1>글자를 소중히 다루지 않으면 데이터가 날아갈 테다</h1>");
	} 
	%>

	<%!
	private void printpage(int totalCnt, int cntnumber, ServletResponse response, int firstpagenumber) throws IOException {
		
		int totalpage = (totalCnt / cntnumber) + 1;
		int last_start = ((totalpage / 10) * 10) + 1;
		int last_last = totalpage % 10;
		
		
		PrintWriter pw = response.getWriter();
		
		if (firstpagenumber == last_start) {
			for (int i = 1; i <= last_last; i++) {
				pw.printf("<a href='WIFI.jsp?from=" + (firstpagenumber + i - 2) * cntnumber + "&cnt=" + cntnumber + "'>" + (firstpagenumber + i - 1) + " </a>");
			}	
		} else {

			pw.printf("<a href='WIFI.jsp?from=" + (firstpagenumber - 1) * cntnumber + "&cnt=" + cntnumber + "'>" + (firstpagenumber + 0) + " </a>");
			pw.printf("<a href='WIFI.jsp?from=" + (firstpagenumber - 0) * cntnumber + "&cnt=" + cntnumber + "'>" + (firstpagenumber + 1) +" </a>");
			pw.printf("<a href='WIFI.jsp?from=" + (firstpagenumber + 1) * cntnumber + "&cnt=" + cntnumber + "'>" + (firstpagenumber + 2) +" </a>");
			pw.printf("<a href='WIFI.jsp?from=" + (firstpagenumber + 2) * cntnumber + "&cnt=" + cntnumber + "'>" + (firstpagenumber + 3) +" </a>");
			pw.printf("<a href='WIFI.jsp?from=" + (firstpagenumber + 3) * cntnumber + "&cnt=" + cntnumber + "'>" + (firstpagenumber + 4) +" </a>");
			pw.printf("<a href='WIFI.jsp?from=" + (firstpagenumber + 4) * cntnumber + "&cnt=" + cntnumber + "'>" + (firstpagenumber + 5) +" </a>");
			pw.printf("<a href='WIFI.jsp?from=" + (firstpagenumber + 5) * cntnumber + "&cnt=" + cntnumber + "'>" + (firstpagenumber + 6) +" </a>");
			pw.printf("<a href='WIFI.jsp?from=" + (firstpagenumber + 6) * cntnumber + "&cnt=" + cntnumber + "'>" + (firstpagenumber + 7) +" </a>");
			pw.printf("<a href='WIFI.jsp?from=" + (firstpagenumber + 7) * cntnumber + "&cnt=" + cntnumber + "'>" + (firstpagenumber + 8) +" </a>");
			pw.printf("<a href='WIFI.jsp?from=" + (firstpagenumber + 8) * cntnumber + "&cnt=" + cntnumber + "'>" + (firstpagenumber + 9) +" </a>");
		}
	}
	%>













</body>
</html>