package com.ahnkyuweb0607.jsp;

import java.io.IOException;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/TodoController"})
public class TodoController extends HttpServlet { // super class, sub class

    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    List<ToDo> items = Arrays.asList(new ToDo(), new ToDo());
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
    }
    String haha = "";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException {
        String title = request.getParameter("todo");
        
        System.out.println("hhhhhhhhhhhhhhhhhhhhhhhhhhh" + title);
        
        TodoRepository repository = TodoRepository.getInstance(); // 이거로만 접근 가능 .. 이게 싱글톤 패턴
        repository.addToDo(title);
        
        HttpSession session = request.getSession();
        session.setAttribute("todos_session", repository.getTodos());
        
        request.getRequestDispatcher("todolist3.jsp").forward(request, resp);
    }
}
