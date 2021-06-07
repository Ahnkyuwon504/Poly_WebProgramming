<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.ahnkyuweb0607.jsp.ToDo" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TodoList</title>
<link rel="stylesheet" href="Form.css">
<link rel="stylesheet" href="TodoItem.css">
<link rel="stylesheet" href="TodoListTemplate.css">
</head>
<body>

  <%
  request.setCharacterEncoding("utf-8");
  List<ToDo> toDoList = (ArrayList<ToDo>) session.getAttribute("toDoList_session");
  
  if (toDoList == null) {
      toDoList = new ArrayList<ToDo>();
  }
  
  String toDoName = request.getParameter("toDoName_key");
  Boolean toDoCheck = Boolean.parseBoolean(request.getParameter("toDoCheck_key"));
  
  if (toDoName != null && toDoCheck != null && !toDoName.isEmpty()) {
      boolean dupli = false;
      
      for (ToDo todo : toDoList) {
          if (todo.getTodoName().equals(toDoName)) dupli = true;
      }
      
      if (dupli == false) toDoList.add(new ToDo(toDoName, toDoCheck));
  }
  
  session.setAttribute("toDoList_session", toDoList);
  %>
  
  <div class="title">
     오늘 할 일
  </div>
  <div class="form">
    <form method="post">
        <input name="toDoName_key" class="form-wrapper"/>
        <input type='hidden' name='toDoCheck_key' value='false'/>
        <button class="create-button">추가</button>
    </form>
  </div>
  <div class="todo-item">
    <table>
    <%
      int numberOftoDo = toDoList.size();
      
      for (int i = 0; i < numberOftoDo; i++) {
    %>
      <tr>
        <td>
          <p>
            <% out.print(toDoList.get(i).getTodoName()); %>
          </p>
        </td>
        <td>
          <p>
            <% out.print(toDoList.get(i).isTodoCheck()); %>
          </p>   
        </td>      
      </tr>
    <%      
      }
    %>
    </table>
  </div>
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  






</body>
</html>