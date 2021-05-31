<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Practice03</title>
<head>
<%!
	private String call1() {
		String a = "abc";
		String b = "efg";
		return (a+b);
}

private Integer call2() {
	Integer a = 1;
	Integer b = 2;
	return (a+b);
}
%>
</head>
</head>
<body>
String연산 : <%=call1()%> <br>
Integer연산 : <%=call2()%>
</body>
</html>