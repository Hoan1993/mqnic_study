<%--
  Created by IntelliJ IDEA.
  User: jokeunwan
  Date: 2020/10/01
  Time: 8:12 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core_1_1" %>
<%@ page session="false" import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>Insert title here</title>
</head>
<body>

<h4>
    <c:out value="${exception.getMessage()}"></c:out>
</h4>

<ul>
    <c:forEach items="${exception.getStackTrace()}" var="stack">
        <li><c:out value="${stack}"></c:out></li>
    </c:forEach>
</ul>

</body>
</html>
