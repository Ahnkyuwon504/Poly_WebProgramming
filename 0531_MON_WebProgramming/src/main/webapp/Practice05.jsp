<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%!
String arr[] = new String[]{"111", "222", "333"};
%>

<%
try {
	out.println(arr[4] + "<br");
} catch (Exception e) {
	out.println("error==>" + e + "<==<br>");
}
%>

</body>
</html>