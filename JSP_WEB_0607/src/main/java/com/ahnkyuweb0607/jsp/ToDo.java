package com.ahnkyuweb0607.jsp;

import java.io.Serializable;
import java.util.concurrent.atomic.AtomicInteger;

public class ToDo implements Serializable {
    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    private static final AtomicInteger counter = new AtomicInteger(0);  // 멤버변수가 아님...
    
    private long id;
    private String title;   // 암묵적으로 null
    private boolean isDone; // 암묵적으로 false
    
    public ToDo() {
        id = counter.getAndIncrement();
    }
    
    public ToDo(String title) {
        // 위에꺼 복붙하면 안됨...
        this();             // 기본생성자 호출, super()는 interface를 갖다쓰기때문에 안됨...부모 생성자없어.
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

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
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
