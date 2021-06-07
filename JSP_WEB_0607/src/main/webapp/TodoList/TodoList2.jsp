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
  
<div id="root">
  <main class="todo-list-template">
  
    <div class="title">
      오늘 할 일
    </div>
    
    <section class="palette-wrapper">
      <div class="palette">
      <div class="color active" style="background: rgb(52, 58, 64);">
      </div>
      <div class="color false" style="background: rgb(240, 62, 62);">
      </div>
      <div class="color false" style="background: rgb(18, 184, 134);">
      </div>
      <div class="color false" style="background: rgb(34, 138, 230);">
      </div>
      </div>
    </section>
    
    <section class="form-wrapper">
      <div class="form">
        <form method="post" sty>
        <input name="toDoName_key" style="color: rgb(52, 58, 64);">
        <input type='hidden' name='toDoCheck_key' value='false'/>
        <button class="create-button">추가</button>
        </form>
      </div>
    </section>
    
    <section class="todos-wrapper">
      <div>
<%
int numberOftoDo = toDoList.size();

for (int i = 0; i < numberOftoDo; i++) {
%>
        <div class="todo-item" onclick="">
          <div class="remove">x</div>
              
  <%
  if ( toDoList.get(i).isTodoCheck() == true ) {
  %>
          <div class="todo-text checked">
            <div> 
              <% out.print(toDoList.get(i).getTodoName()); %>
            </div>
            <div class="check-mark">✓</div>
          </div>
  <% 
  } else {
  %>
          <div class="todo-text false">
            <div>
               <% out.print(toDoList.get(i).getTodoName()); %>
            </div>
          </div>
  <% 
  }
  %>
        </div>
<%
}
%>
      </div>
    </section>
  </main>
</div>
</body>
</html>