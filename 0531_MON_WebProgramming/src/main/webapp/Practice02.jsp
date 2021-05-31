<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Practice02</title>
function call1() {
	var a = "abc";
	var b = "efg";
	document.write("String연산 : " + (a+b));
}

function call2() {
	var a = 1;
	var b = 2;
	document.write("integer연산 : " + (a+b));
}
</head>
<body>
<script>call1();</script>
<script>call2();</script>
</body>
</html>