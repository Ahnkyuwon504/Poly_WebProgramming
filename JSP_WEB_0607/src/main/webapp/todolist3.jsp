<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>todolist3</title>
<style>
  .done {
    text-decoration: line-through;
    color : red;
  }
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
  integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
  crossorigin="anonymous"></script>
<script>
  function toggle(id, isDone) {
    
    /* console.log(id);
    console.log(isDone);
    
    var xhr = new XMLHttpRequest();
    xhr.open("POST", "TodoController", true);
    xhr.setRequestHeader('Content-Type', 'application/json');
    
    var json = {
        todo: "test"
        soso: "허허"
    };
    
    xhr.send(JSON.stringify(json)); */
    
    $.ajax({
      type: "POST"
      , url: "addTodo"
      , data: {id:id, done:isDone}
      , success:function(data) {
        location.href = "todolist3.jsp";
      }
      , error:function(data) {
        alert(data);
      }
    });
    
    
  }
</script>
</head>
<body>
  <form action="TodoController" method="post">
    <input type="text" name="todo" placeholder="할 일"/>
    <button>추가</button>
  </form>
  
  <ul>
    <c:forEach var="todo" items="${todos_session}">
      <li onclick="toggle(${todo.id}, ${todo.isDone()})">${todo.title}</li>
    </c:forEach>
    <li class="done">어제 한 일</li>
  </ul>
</body>
</html>