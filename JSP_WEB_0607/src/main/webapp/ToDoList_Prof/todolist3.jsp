<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.ahnkyuweb0607.jsp.TodoRepository" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>todolist</title>
<style>
  .done {
    text-decoration: line-through;
    color : red;
  }
</style>
</head>
<body>
<%
  String title = request.getParameter("todo");
  request.setCharacterEncoding("utf-8");

  // TodoRepository repository = new TodoRepository(); // 불가능
  TodoRepository repository = TodoRepository.getInstance(); // 이거로만 접근 가능 .. 이게 싱글톤 패턴
  
  
  repository.addToDo(title);
  
  session.setAttribute("todos_session", repository.getTodos());
  


%>

  <form method="post">
    <input type="text" name="todo" placeholder="할 일"/>
    <button>추가</button>
  </form>
  
  <ul>
    <li>오늘 할 일</li>
    <li>내일 할 일</li>
    <c:forEach var="todo" items="${todos_session}">
      <li>${todo.title}</li>
    </c:forEach>
    <li class="done"></li>
  </ul>











</body>
</html>