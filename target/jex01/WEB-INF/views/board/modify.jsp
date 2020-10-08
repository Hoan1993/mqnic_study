<%--
  Created by IntelliJ IDEA.
  User: jokeunwan
  Date: 2020/10/05
  Time: 4:08 오후
  To change this template use File | Settings | File Templates.
--%>

<%-- modify.jsp는 get.jsp와 같지만 수정이 가능한 '제목'이나 '내용' 등이 readonly 속성이 없도록 작성한다.--%>
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

            <form role="form" action="/board/modify" method="post">

                <%-- 리스트로 돌아갈 때, 원래 있던 페이지로 돌아가기 위해서
                    무조건 1페이지로 돌아가는 것이 아니라--%>
                <input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}" />'>
                <input type="hidden" name="amount" value='<c:out value="${cri.amount}" />'>
                    <input type="hidden" name="keyword" value='<c:out value="${cri.keyword}"/>'>
                    <input type="hidden" name="type" value='<c:out value="${cri.type}"/>'>


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
                    <textarea class="form-control" rows="3" name="content">
                            <c:out value="${board.content}" />
                        </textarea>
                </div>

                <div class="form-group">
                    <label>Writer</label>
                    <input class="form-control" name="writer" value='<c:out value="${board.writer}" />'>
                </div>

                <div class="form-group">
                    <label>Update Date</label>
                    <input class="form-control" name="regDate"
                    value='<c:out value="${board.regdate}" />' readonly="readonly">
                </div>

                <div class="form-group">
                    <label>Update Date</label>
                    <input class="form-control" name="updateDate"
                           value='<c:out value="${board.updateDate}" />' readonly="readonly">
                </div>

                <button type="submit" data-oper="modify" class="btn btn-default">Modify</button>
                <button type="submit" data-oper="remove" class="btn btn-danger">Remove</button>
                <button type="submit" data-oper="list" class="btn btn-info">List</button>

                <%--<button data-oper="modify" class="btn btn-default" onclick="location.href='/board/modify?bno=<c:out value="${board.bno}" />'">Modify</button>
                <button data-open="list" class="btn btn-info" onclick="location.href='/board/list'">List</button>--%>

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
       var formObj = $("form");

       $('button').on("click", function (e) {
           e.preventDefault();

           var operation = $(this).data("oper");

           /* oper에 눌려진 버튼의 기능이 담겨져 있다*/
           console.log(operation);

           // 해당 오퍼레이션이 무엇인지에 따라 작업이 이루어진다.
           // 삭제할지 또는 리스트로 갈 지.
           // form 태그의 모든 버튼은 기본적으로 submit으로 처리하기 때문에
           // e.preventDefault()로 기본 동작을 막고(/board/modify 액션을 해 버리는 것)
           if(operation === 'remove') {
               formObj.attr("action", "/board/remove");
           } else if(operation === 'list') {
               // 요청 받은게 list이면
               // action 속성과 method 속성을 변경한다.


               // move to list
               formObj.attr("action", "/board/list").attr("method", "get");
               var pageNumTag = $("input[name='pageNum']").clone();
               var amountTag = $("input[name='amount']").clone();
               var keywordTag = $("input[name='keyword']").clone();
               var typeTag = $("input[name='type']").clone();


               // /board/list로의 이동은 아무런 파라미터가 없기 때문에 <form> 태그의 모든 내용은
               // 삭제한 상태에서 submit을 진행한다.
               formObj.empty();
               formObj.append(pageNumTag);
               formObj.append(amountTag);
               formObj.append(keywordTag);
               formObj.append(typeTag);

               /*self.location = "/board/list";
               return;*/
           }

           // 마지막에 직접 submit을 수행한다.
           formObj.submit();

       });


    });

</script>
