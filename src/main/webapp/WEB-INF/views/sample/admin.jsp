<%--
  Created by IntelliJ IDEA.
  User: jokeunwan
  Date: 2020/10/16
  Time: 2:42 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core_1_1"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <title>Title</title>
</head>
<body>
<%-- admin --%>
<h1>/sample/admin page</h1>

<p>principal : <sec:authentication property="principal" /></p>
<p>MemberVO : <sec:authentication property="principal.member" /></p>
<p>사용자이름 : <sec:authentication property="principal.member.username" /></p>
<p>사용자아이디 : <sec:authentication property="principal.member.userid" /></p>
<p>사용자 권한 리스 : <sec:authentication property="principal.member.authList" /></p>


<a href="/customLogout">Logout</a>

</body>
</html>
