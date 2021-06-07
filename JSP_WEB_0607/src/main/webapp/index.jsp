<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <h1>Hello World</h1>
  
  <%@ page import="com.ahnkyuweb0607.jsp.Person"  %>
  
  <%
  Person person1 = new Person("홍길동", 10);
  Person person2 = new Person("홍길동", 10);
  
  out.println(person1.equals(person2)); // 값을 비교
  out.println(person1 == person2); // reference(주소) 비교
  %>
  
  <!--  true or false -->
  <%= person1.equals(person2)%>
  
</body>
</html>