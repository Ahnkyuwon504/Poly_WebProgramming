package com.ahnkyuweb0607.jsp;

import java.io.Serializable;

public class ToDo implements Serializable {
    private String title;   // 암묵적으로 null
    private boolean isDone; // 암묵적으로 false
    
    public ToDo() {
        
    }
    
    public ToDo(String title) {
        this.title = title;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public boolean isDone() {
        return isDone;
    }

    public void setDone(boolean isDone) {
        this.isDone = isDone;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + (isDone ? 1231 : 1237);
        result = prime * result + ((title == null) ? 0 : title.hashCode());
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
        if (isDone != other.isDone)
            return false;
        if (title == null) {
            if (other.title != null)
                return false;
        } else if (!title.equals(other.title))
            return false;
        return true;
    }

    @Override
    public String toString() {
        return "ToDo [title=" + title + ", isDone=" + isDone + "]";
    }
}
