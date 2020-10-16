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

<%-- 원본 이미지를 보여주는 부분 --%>
<div class="bigPictureWrapper">
    <div class="bigPicture">

    </div>
</div>
<%-- 첨부 파일 관련 css --%>
<style>
    .uploadResult {
        width: 100%;
        background-color: gray;
    }

    .uploadResult ul {
        display: flex;
        flex-flow: row;
        justify-content: center;
        align-items: center;
    }

    .uploadResult ul li {
        list-style: none;
        padding: 10px;
        align-content: center;
        text-align: center;
    }

    .uploadResult ul li img {
        width: 100px;
    }

    .uploadResult ul li span {
        color: white;
    }

    .bigPictureWrapper {
        position: absolute;
        display: none;
        justify-content: center;
        top: 0%;
        width: 100%;
        height: 100%;
        background-color: gray;
        z-index: 100;
        background: rgba(255,255,255,0.5);
    }

    .bigPicture {
        position: relative;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .bigPicture img {
        width: 600px;
    }
</style>

<%-- 첨부 파일 목록을 보여주는 영역--%>
<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">

            <div class="panel-heading">Files</div>
            <%-- /.panel-heading --%>
            <div class="panel-body">
                <div class="form-group uploadDiv">
                    <input type="file" name="uploadFile" multiple>
                </div>


                <div class="uploadResult">
                    <ul>
                    </ul>
                </div>
            </div>
            <%-- end panel-body --%>
        </div>
        <%-- end panel-body --%>
    </div>
    <%-- end panel --%>
</div>
<%-- /.row--%>



<%@include file="../includes/footer.jsp"%>

<script type="text/javascript">
    $(document).ready(function () {
        /* 게시물 조회 화면의 처리 */
        (function () {
            var bno = '<c:out value="${board.bno}"/>';

            $.getJSON("/board/getAttachList", {bno: bno}, function (arr) {
                console.log(arr);

                var str = "";

                $(arr).each(function (i, attach) {

                    // image type
                    if(attach.fileType) {
                        var  fileCallPath = encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);


                        /*str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' " +
                            " data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'>" +
                            "<div>" +
                            "<img src='/display?fileName="+fileCallPath+"'>" +
                            "</div></li>";*/

                        str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' " +
                            " data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'>" +
                            "<div>" +
                            "<span> "+attach.fileName+"</span>" +
                            "<button type='button' data-file=\'"+fileCallPath+"\' " +
                            " data-type='image' class='btn btn-warning btn-circle'>" +
                            "<i class='fa fa-times'></i></button><br>" +
                            "<img src='/display?fileName="+fileCallPath+"'>" +
                            "</div></li>";


                    } else {
                        /*str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' " +
                            " data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'>" +
                            "<div>" +
                            "<span> "+attach.fileName+"</span><br/>" +
                            "<img src='/resources/img/attach.png'>" +
                            "</div></li>";*/

                        var fileCallPath = encodeURIComponent(attach.uploadPath+"/"+attach.uuid+"_"+attach.fileName);

                        str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' " +
                            " data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'>" +
                            "<div>";
                        str += "<span> "+attach.fileName+"</span>";
                        str += "<button type='button' data-file=\'"+fileCallPath+"\' " +
                            " data-type='file' class='btn btn-warning btn-circle'>" +
                            "<i class='fa fa-times'></i></button><br>";
                        str += "<img src='/resources/img/attach.png'>";
                        str += "</div>";
                        str += "</li>";

                    }

                });

                $(".uploadResult ul").html(str);


            }); // end getjson

        })(); // end function

        // 게시물 조회 화면 처리 부분 끝
    });

    $(".uploadResult").on("click", "li", function (e) {
        console.log("delete file");

        if(confirm("Remove this file? ")) {
            var targetLi = $(this).closest("li");
            targetLi.remove();
        }

    });

    /* 첨부파일 추가 부분*/

    var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
    var maxSize = 5242880; // 5MB

    // 테스트 용도
    /*var maxSize = 1; // */

    function checkExtension(fileName, fileSize) {
        if(fileSize >= maxSize) {
            alert("파일 사이즈 초과");
            return false;
        }

        if(regex.test(fileName)) {
            alert("해당 종류의 파일은 업로드할 수 없습니다.");
            return false;
        }

        return true;
    }

    $("input[type='file']").change(function (e) {
        var formData = new FormData();

        var inputFile = $("input[name='uploadFile']");

        var files = inputFile[0].files;

        for(var i=0; i<files.length; i++) {
            if(!checkExtension(files[i].name, files[i].size)) {
                return false;
            }
            formData.append("uploadFile", files[i]);

        }

        $.ajax({
            url: '/uploadAjaxAction',
            processData: false,
            contentType: false,
            data: formData,
            type: 'POST',
            dataType: 'json',
            success: function (result) {
                console.log(result);
                showUploadResult(result)
            }
        });
    });


    function showUploadResult(uploadResultArr) {
        if(!uploadResultArr || uploadResultArr.length == 0) {
            return;
        }

        var uploadUL = $(".uploadResult ul");

        var str = "";

        $(uploadResultArr).each(
            function (i, obj) {

                if (obj.image) {
                    var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
                    alert("체크: "+fileCallPath);

                    var originPath = obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName;

                    originPath = originPath.replace(new RegExp(/\\/g), "/");

                    str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' " +
                        " data-filename='"+obj.fileName+"' data-type='"+obj.image+"'>" +
                        "<div>" +
                        "<span> "+obj.fileName+"</span>" +
                        "<button type='button' data-file=\'"+fileCallPath+"\' " +
                        " data-type='image' class='btn btn-warning btn-circle'>" +
                        "<i class='fa fa-times'></i></button><br>" +
                        "<a href=\"javascript:showImage(\'"+originPath+"\')\">" +
                        "<img src='/display?fileName="+fileCallPath+"'></a> " +
                        "</div></li>";



                } else {
                    /*str += "<li>" + obj.fileName + "</li>";*/
                    var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
                    var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");

                    str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' " +
                        " data-filename='"+obj.fileName+"' data-type='"+obj.image+"'>" +
                        "<div>";
                    str += "<span> "+obj.fileName+"</span>";
                    str += "<button type='button' data-file=\'"+fileCallPath+"\' " +
                        " data-type='image' class='btn btn-warning btn-circle'>" +
                        "<i class='fa fa-times'></i></button><br>";
                    str += "<img src='/resources/img/attach.png'>";
                    str += "</div>";
                    str += "</li>";

                }

            });

        uploadUL.append(str);

    }


</script>
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
           } else if(operation === 'modify') {
               console.log("submit clicked");

               var str = "";

               $(".uploadResult ul li").each(function (i, obj) {
                   console.log("uploadResult ul li에 들어왔습니다.");
                   var jobj = $(obj);

                   console.dir(jobj);

                   str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
                   str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
                   str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
                   str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";

               });

               formObj.append(str).submit();

           }

           // 마지막에 직접 submit을 수행한다.
           formObj.submit();

       });


    });
</script>

