<%--
  Created by IntelliJ IDEA.
  User: jokeunwan
  Date: 2020/10/05
  Time: 1:09 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%@include file="../includes/header.jsp"%>

<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">Tables</h1>
    </div>
    <!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                Board Register
            </div>
            <!-- /.panel-heading -->
            <div class="panel-body">

                <form role="form" action="/board/register" method="post">
                    <div class="form-group">
                        <label>Title</label>
                        <input class="form-control" name="title">

                    </div>
                    <div class="form-group">
                        <label>Text area</label>
                        <textarea class="form-control" rows="3" name="content"></textarea>
                    </div>

                    <div class="form-group">
                        <label>Writer</label>
                        <input class="form-control" name="writer">
                    </div>

                    <button type="submit" class="btn btn-default">Submit Button</button>
                    <button type="reset" class="btn btn-default">Reset Button</button>

                </form>

            </div>
            <%-- end panel body--%>
        </div>
        <%-- end panel --%>
    </div>
</div>
<%-- /. row --%>
<%@include file="../includes/footer.jsp"%>
