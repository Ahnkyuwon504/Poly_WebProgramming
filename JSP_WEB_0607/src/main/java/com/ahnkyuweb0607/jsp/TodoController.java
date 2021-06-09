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

@WebServlet(urlPatterns = {"/TodoController", "/addTodo"})
public class TodoController extends HttpServlet { // super class, sub class

    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    List<ToDo> items = Arrays.asList(new ToDo(), new ToDo());
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse resp) throws ServletException, IOException {
        String command = request.getRequestURI()
                .substring(request.getContextPath().length());
        
        if ("/TodController".equals(command)) {  // 이게 안전해. true or false는 주니까..
            String title = request.getParameter("todo");
            
            System.out.println("hhhhhhhhhhhhhhhhhhhhhhhhhhh" + title);
            
            TodoRepository repository = TodoRepository.getInstance(); // 이거로만 접근 가능 .. 이게 싱글톤 패턴
            repository.addToDo(title);
            
            HttpSession session = request.getSession();
            session.setAttribute("todos_session", repository.getTodos());
            
            request.getRequestDispatcher("todolist3.jsp").forward(request, resp);
            
        } else if (command.equals("/addTodo")) { // command가 null이면 터져..
            String id = request.getParameter("id");
            String done = request.getParameter("done");
            
            System.out.println("id : " + id + ", done : " + done );
            
            TodoRepository repository = TodoRepository.getInstance(); // 이거로만 접근 가능 .. 이게 싱글톤 패턴

            TodoRepository.getInstance().toggle(Long.valueOf(id),  Boolean.valueOf(done));
            
            
            request.getRequestDispatcher("todolist3.jsp").forward(request, resp);
        }
        
       
    }
}
