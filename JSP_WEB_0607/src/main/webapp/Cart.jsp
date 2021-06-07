<%@ page import="com.ahnkyuweb0607.jsp.Cart"%>
<%@ page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cart</title>
</head>
<body>

  <h1>장바구니</h1>
  
  <%
  Set<Cart> cartItems = (HashSet<Cart>)session.getAttribute("cartItems");
  if (cartItems == null) {
      cartItems = new HashSet<Cart>();
  }
  
  request.setCharacterEncoding("utf-8");
  
  String name = request.getParameter("name_key");
  String amount = request.getParameter("amount_key");
  
  if (name != null && amount != null && !name.isEmpty() && !amount.isEmpty()) {
      cartItems.add(new Cart(name, amount));
  }
  
  session.setAttribute("cartItems", cartItems);
  
  /* Iterator it = cartItems.iterator();
  while (it.hasNext()) {
      out.print(it.next().getName() + ", ");
  } */
  
  
 // out.print(cartItems);
  
  
  
  //out.print("객체의 ArrayList를 session에 저장한 후 가져오기 : " + session.getAttribute("cartItems") + "<br>");
  %>
  <form method="post" action="Cart.jsp">
    <input name="name_key" type='text' placeholder='상품명'>
    <input name="amount_key" type='text' placeholder='수량'>
    <button>추가</button>
  </form>
  <ul>
    <c:forEach var="cart" items="${cartItems}">
      <li>${cart}</li>
    </c:forEach>
  </ul>
</body>
</html>