package com.ahnkyuweb0607.jsp;

public class ToDo {
    private String todoName;
    private boolean todoCheck;
    
    public ToDo(String todoName, boolean todoCheck) {
        super();
        this.todoName = todoName;
        this.todoCheck = todoCheck;
    }
    
    public String getTodoName() {
        return todoName;
    }
    public void setTodoName(String todoName) {
        this.todoName = todoName;
    }
    public boolean isTodoCheck() {
        return todoCheck;
    }
    public void setTodoCheck(boolean todoCheck) {
        this.todoCheck = todoCheck;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + (todoCheck ? 1231 : 1237);
        result = prime * result + ((todoName == null) ? 0 : todoName.hashCode());
        return result;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        ToDo other = (ToDo) obj;
        if (todoCheck != other.todoCheck)
            return false;
        if (todoName == null) {
            if (other.todoName != null)
                return false;
        } else if (!todoName.equals(other.todoName))
            return false;
        return true;
    }

    @Override
    public String toString() {
        return "ToDo [todoName=" + todoName + ", todoCheck=" + todoCheck + "]";
    }
}
