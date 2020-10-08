<%--
  Created by IntelliJ IDEA.
  User: jokeunwan
  Date: 2020/10/04
  Time: 3:30 오후
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
                        Board List Page
                        <button id="regBtn" type="button" class="btn btn-xs pull-right">
                            Register New Board
                        </button>
                    </div>
                    <!-- /.panel-heading -->
                    <div class="panel-body">
                        <table class="table table-striped table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th>#번호</th>
                                    <th>제목</th>
                                    <th>작성자</th>
                                    <th>작성일</th>
                                    <th>수정일</th>
                                </tr>
                            </thead>

                            <c:forEach var="board" items="${list}" >
                                <tr>
                                    <td><c:out value="${board.bno}" /> </td>
                                    <td>
                                        <a class="move" href='<c:out value="${board.bno}"/>'>
                                            <c:out value="${board.title}" />
                                        </a>
                                    </td>

                                    <%--
                                    <td><a href='/board/get?bno=<c:out value="${board.bno}" />'>
                                            <c:out value="${board.title}" />
                                        </a>
                                    </td>
                                    --%>
                                    <td><c:out value="${board.writer}" /> </td>
                                    <td><c:out value="${board.regdate}" /> </td>
                                    <td><c:out value="${board.updateDate}" /> </td>

                                    <%--<td><fmt:formatDate type="time" pattern="yyyy-MM-dd" value="${board.regdate}" /></td>
                                    <td><fmt:formatDate type="time" pattern="yyyy-MM-dd" value="${board.updateDate}" /></td>--%>
                                </tr>
                            </c:forEach>

                        </table> <%-- 테이블 태그의 끝--%>


                        <%-- 검색 태그의 시작--%>
                        <div class="row">
                            <div class="col-lg-12">
                                <form id="searchForm" action="/board/list" method="get">
                                    <select name="type">
                                        <option value="" <c:out value="${pageMaker.cri.type == null ? 'selected' : '' }" /> >--</option>
                                        <option value="T" <c:out value="${pageMaker.cri.type eq 'T' ? 'selected' : '' }" />>제목</option>
                                        <option value="C" <c:out value="${pageMaker.cri.type eq 'C' ? 'selected' : '' }" />>내용</option>
                                        <option value="W" <c:out value="${pageMaker.cri.type eq 'W' ? 'selected' : '' }" />>작성자</option>
                                        <option value="TC" <c:out value="${pageMaker.cri.type eq 'TC' ? 'selected' : '' }" />>제목 or 내용</option>
                                        <option value="TW" <c:out value="${pageMaker.cri.type eq 'TW' ? 'selected' : '' }" />>제목 or 작성자</option>
                                        <option value="TWC" <c:out value="${pageMaker.cri.type eq 'TWC' ? 'selected' : '' }" />>제목 or 내용 or 작성자</option>
                                    </select>
                                    <%--<input type="text" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>' />
                                    <input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum}"/>' />
                                    <input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount}"/>' />--%>
                                    <input type="text" name="keyword" value="<c:out value='${pageMaker.cri.keyword }'/>"/>
                                    <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }" />
                                    <input type="hidden" name="amount" value="${pageMaker.cri.amount }" />

                                    <button class="btn btn-default">Search</button>
                                </form>
                            </div>
                        </div>


                        <%-- 검색 태그의 끝--%>

                        <div class='pull-right'>
                            <ul class="pagination">
                                <c:if test="${pageMaker.prev}">
                                    <li class="paginate_button previous">
                                        <a href="${pageMaker.startPage -1}">Previous</a>
                                    </li>
                                </c:if>

                                <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                                    <li class="paginate_button ${pageMaker.cri.pageNum == num ? "active":""}">
                                        <a href="${num}">${num}</a>
                                    </li>
                                </c:forEach>

                                <c:if test="${pageMaker.next}">
                                    <li class="paginate_button next">
                                        <a href="${pageMaker.endPage+1}">Next</a>
                                    </li>
                                </c:if>
                            </ul>
                        </div>
                        <%-- end Pagination --%>



                        <%-- modal 추가 --%>
                        <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
                             aria-labelledby="myModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal"
                                                aria-hidden="true">&times;</button>
                                        <h4 class="modal-title" id="myModalLabel">
                                            Modal title
                                        </h4>
                                    </div>
                                    <div class="modal-body">처리가 완료되었습니다.</div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                        <button type="button" class="btn btn-primary">Save changes</button>
                                    </div>
                                </div>
                                <%-- /.modal-content --%>
                            </div>
                            <%-- /. modal-dialog--%>
                        </div>
                        <%-- /.modal--%>



                        <form id="actionForm" action="/board/list" method="get">
                            <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
                            <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
                            <input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type}"/>'/>
                            <input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword}"/>'/>
                        </form>
                    </div>
                    <%-- end panel body--%>
                </div>
                <%-- end panel --%>
            </div>
        </div>
            <%-- /. row --%>
    <%@include file="../includes/footer.jsp"%>

<%-- 만약 result에 결과가 있다면 --%>
<script type="text/javascript">
    $(document).ready(function () {
       var result = '<c:out value="${result}"/>';

       checkModal(result);

       history.replaceState({}, null, null);

       function checkModal(result) {

           // result에 아무것도 없거나, history.state에 표시가 되어 있다면
           // 그냥 return함.
           if(result === '' || history.state) {
               return;
           }

           // 등록 버튼이 눌러졌고,
           // 그게 첫번째일 때
           // 그 글의 번호
           if(parseInt(result) > 0) {
               $(".modal-body").html("게시글 "+parseInt(result) +" 번이 등록되었습니다.");
           }

           $("#myModal").modal("show");
       }

       $("#regBtn").on("click", function () {
          self.location = "/board/register";
       });

       var actionForm = $("#actionForm");

       $(".paginate_button a").on("click", function (e) {
           // 자바스크립트에서 <a> 태그를 클릭해도 페이지 이동이 없도록
           // preventDefault() 처리를 했다.
           e.preventDefault();

           console.log('click');

           actionForm.find("input[name='pageNum']").val($(this).attr("href"));
           actionForm.submit();
       })


        $(".move").on("click", function (e) {
            e.preventDefault();

            actionForm.append("<input type='hidden' name='bno' value='"+
                $(this).attr("href")+"'>");
            actionForm.attr("action", "/board/get");
            actionForm.submit();

        });


       var searchForm = $("#searchForm");

       $("#searchForm button").on("click", function (e) {

           if(!searchForm.find("option:selected").val()) {
               alert("검색종류를 선택하세요");
               return false;
           }

           if(!searchForm.find("input[name='keyword']").val()) {
               alert("키워드를 입력하세요");
               return false;
           }

           searchForm.find("input[name='pageNum']").val("1");
           e.preventDefault();

           searchForm.submit();

       });


    });

</script>



