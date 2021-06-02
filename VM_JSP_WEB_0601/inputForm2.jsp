<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>inputForm2</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script>
	var replaceNotInt = /[^0-9]/gi;
    
    $(document).ready(function(){
        
        $("#inputPhone").on("focusout", function() {
            var x = $(this).val();
            if (x.length > 0) {
                if (x.match(replaceNotInt)) {
                   x = x.replace(replaceNotInt, "");
                }
                $(this).val(x);
            }
        }).on("keyup", function() {
            $(this).val($(this).val().replace(replaceNotInt, ""));
        });
 
    });
  
  </script>
</head>
<body>
<h1>성적 조회 후 정정/삭제</h1><br>
<form action='./showREC.jsp' method='get' target='main3'>
	조회 학번&nbsp;<input id='inputPhone' type='text' name='studentid'>
	&nbsp;&nbsp;<input type='submit' value='조회'>
</form>
</body>
</html>