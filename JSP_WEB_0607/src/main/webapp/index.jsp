<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index</title>
</head>
<body>
  <h1>Hello World</h1>
  
  <%@ page import="com.ahnkyuweb0607.jsp.Person"  %>
  
  <%
  Person person1 = new Person("홍길동", 10); // 100번지
  Person person2 = new Person("홍길동", 10); // 200번지 
  
  out.println("equal로 비교 : " + person1.equals(person2) + "<br>"); // 값을 비교
  out.println("==으로 비교 : " + (person1 == person2) + "<br>"); // reference(주소) 비교
  %>
  <br>
  <h1>HashCode</h1>
  <%
  out.println("person1 객체 자체를 프린트 : " + person1 + "<br>");
  out.println("person2 객체 자체를 프린트 : " + person2 + "<br>");
  %>
  <%!
  // 상대적으로 안 좋은 방법, Arraylist만 사용할 수 있음...
  void something(ArrayList<Person> list, Person person) {
      list.add(person);
  }

  // 좋은 방법, 추상적으로 다 쓸 수 있음...
  void something2(List<Person> list, Person person) {
      list.add(person);
  }
  %>
  <%
  ArrayList<Person> items2 = new ArrayList<Person>();
  List<Person> items3 = new ArrayList<Person>();
  List<Person> items4 = new LinkedList<Person>();
  something(items2, person1);
 // something(items3, person1); 실행 불가
 // something(items3, person1); 실행 불가
  something2(items3, person1); // 실행 가능
  something2(items4, person1); // 실행 가능
  out.print("ArrayList에 넣는 something 메소드를 통해 item2에 person1을 담았음 : " + items2 + "<br>");
  %>
  
  
  
  
  <h1>List of HashCode</h1>
  <%@ page import="java.util.*"%>
  <%
  // 레퍼런스 기반... 순서대로 저장  
  // 중복 허용
  List<Person> items = new ArrayList<Person>();
  items.add(person1);
  items.add(person2);
  
  out.print("List로 두 개 : " + items + "<br>");
  
  items.remove(person2);
  
  out.print("List로 한 개 지우고 : " + items + "<br>");
  
  // 해시값 기반... 집합을 표현
  // 중복 불허, 속도 빠름
  Set<Person> itemSet = new HashSet<Person>();
  itemSet.add(person1);
  itemSet.add(person1);
  itemSet.add(person1);
  out.print("HastSet으로 person1 세 개 : " + itemSet + "<br>");
  itemSet.add(person2);
  out.print("HastSet으로 person1 세 개, person2 한 개 : " + itemSet + "<br>");
  %>
  
  <h1>jsp useBean 사용</h1>
  
  
  <jsp:useBean id="person3" class="com.ahnkyuweb0607.jsp.Person" scope="page"/>
  
  
  <%
  out.print(person3);
  %>
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
</body>
</html>