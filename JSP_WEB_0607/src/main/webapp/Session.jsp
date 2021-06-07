<%@page import="com.ahnkyuweb0607.jsp.Person"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Session</title>
<script>
  function nextPage() {
    location.href = "next_page.jsp";
  }
</script>
</head>
<body>
  <%
  // 유효시간 설정
  session.setMaxInactiveInterval(5);
  session.setAttribute("name", "홍길동01");
  
  out.print("session으로 그대로 가져오기 : " + session.getAttribute("name") + "<br>");
  
  // key-value
  session.setAttribute("profile", new Person("안규안규", 10));
  
  // "profile"은 object이기 때문에 형변환
  Person person = (Person) session.getAttribute("profile");
  out.print("객체를 session에 저장한 후 가져오기 : " + person + "<br>");
  
  // Session은 전역변수로 생각하면 편함...
  List<Person> persons = new ArrayList<Person>();
  persons.add(person);
  persons.add(new Person("홍길동02", 20));
  
  session.setAttribute("profiles", persons);
  out.print("객체의 ArrayList를 session에 저장한 후 가져오기 : " + session.getAttribute("profiles") + "<br>");
  %>
  <br>
  <button onclick="nextPage()">next page</button>

</body>
</html>