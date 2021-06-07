<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>next_page</title>
</head>
<body>
  <%
  out.print(session.getAttribute("profiles"));
  %>

</body>
</html>