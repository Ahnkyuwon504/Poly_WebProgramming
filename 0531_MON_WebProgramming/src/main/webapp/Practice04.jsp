<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Practice04</title>
</head>
<body>
<%
String arr[] = new String[]{"111", "222", "333"};
String str = "abc,efg,hij";
String str_arr[] = str.split(",");
%>

arr[0] = <%=arr[0]%> <br>
arr[1] = <%=arr[1]%> <br>
arr[2] = <%=arr[2]%> <br>
str_arr[0] = <%=str_arr[0]%> <br>
str_arr[1] = <%=str_arr[1]%> <br>
str_arr[2] = <%=str_arr[2]%> <br>



</body>
</html>