package com.ahnkyuweb0607.jsp;

import java.util.ArrayList;
import java.util.List;


public class TodoRepository {               // TodoRepository 는 객체를 생성할때나 생기고..
    private static TodoRepository instance; // static은 프로그램 시작과 동시에 메모리에 올라감..
    
    public static TodoRepository getInstance() {
        if (instance ==  null) {
            instance = new TodoRepository();
        }
        return instance;
    }
    
    private TodoRepository() {
        
    }
    
    private List<ToDo> todos = new ArrayList<ToDo>();
    
    public List<ToDo> getTodos() {
        return todos;
    }
    
    public void addToDo(String todo) {
        todos.add(new ToDo(todo));
    }
}
