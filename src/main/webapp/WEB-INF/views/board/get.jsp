<%--
  Created by IntelliJ IDEA.
  User: jokeunwan
  Date: 2020/10/05
  Time: 1:09 오후
  To change this template use File | Settings | File Templates.
--%>

<%-- get.jsp는 게시물 번호를 보여줄 있는 필드를 추가하고, 모든 데이터는 readonly를 지정해서 작성한다.--%>
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
                Board Read Page
            </div>
            <!-- /.panel-heading -->
            <div class="panel-body">

                    <div class="form-group">
                        <label>Bno</label>
                        <input class="form-control" name="bno" value='<c:out value="${board.bno}" />' readonly="readonly">
                    </div>


                    <div class="form-group">
                        <label>Title</label>
                        <input class="form-control" name="title" value='<c:out value="${board.title}" />'>

                    </div>
                    <div class="form-group">
                        <label>Text area</label>
                        <textarea class="form-control" rows="3" name="content" readonly="readonly">
                            <c:out value="${board.content}" />
                        </textarea>
                    </div>

                    <div class="form-group">
                        <label>Writer</label>
                        <input class="form-control" name="writer" value='<c:out value="${board.writer}" />' readonly="readonly">
                    </div>

                    <%--<button data-oper="modify" class="btn btn-default" onclick="location.href='/board/modify?bno=<c:out value="${board.bno}" />'">Modify</button>
                    <button data-open="list" class="btn btn-info" onclick="location.href='/board/list'">List</button>--%>

                     <%-- 여태까지는 직접 버튼에 링크를 처리하는 방식을 사용하여 처리하였지만, 나중에 다양한 상황을 처리하기 위해서 <form> 태그를 이해서 수정한다 --%>
                    <%-- data-oper의 값을 통해 자바스크립트로 처리 --%>
                    <button data-oper='modify' class="btn btn-default">Modify</button>
                    <button data-oper='list' class="btn btn-info">List</button>

                    <form id='operForm' action="/board/modify" method="get">
                        <input type="hidden" id="bno" name="bno" value='<c:out value="${board.bno}"/>'>
                        <input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>'>
                        <input type="hidden" name="amount" value='<c:out value="${cri.amount}"/>'>
                        <input type="hidden" name="keyword" value='<c:out value="${cri.keyword}"/>'>
                        <input type="hidden" name="type" value='<c:out value="${cri.type}"/>'>
                    </form>
            </div>
            <%-- end panel body--%>
        </div>
        <%-- end panel --%>
    </div>
</div>
<%-- /. row --%>
<%@include file="../includes/footer.jsp"%>

<script type="text/javascript">
    $(document).ready(function () {
        var operForm = $("#operForm");

        // operForm이 폼이다.
        // 사용자가 수정 버튼을 누르는 경우에는 bno 값이 같이 전달된다.
        $("button[data-oper='modify']").on("click", function (e) {
            operForm.attr("action", "/board/modify").submit();
        });

        // list에서는 bno가 전달될 이유가 없으므로
        // remove()로 제거한다.
        $("button[data-oper='list']").on("click", function (e) {
            operForm.find("#bno").remove();
            operForm.attr("action", "/board/list")
            operForm.submit();
        });
    });

</script>
