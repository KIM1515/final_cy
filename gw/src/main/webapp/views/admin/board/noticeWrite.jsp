<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file='../../inc/adminTop.jsp'%>
<link rel="stylesheet" href="<c:url value='/css/adminempform.css'/>">
<c:if test="${!empty map['BOARD_NO']}">
	<c:set var="btLabel" value="수정" />
	<c:set var="url" value="/admin/board/noticeEdit" />
	<c:set var="no" value="${map['BOARD_NO']}" />	
</c:if>
<c:if test="${empty map['BOARD_NO'] }">
	<c:set var="btLabel" value="등록" />
	<c:set var="url" value="/admin/board/noticeWrite" />
	<c:set var="no" value="0" />	
</c:if>
<script src="<c:url value='/vendors/tinymce/tinymce.min.js'/>"></script>
<script type="text/javascript">
//에디터에 이미지 삽입 구현해야함
//게시글 임시저장 기능
	$(function(){
        $('#title').focus();
		
		$('input[type=button]').click(function(){
			location.href	= "<c:url value='/admin/board/noticeList'/>";
		});
		
		$('input[type=submit]').click(function(){
		   $('.boardbox').each(function(idx, item){
		      if($(this).val().length <1){
		         alert($(this).prev().text() + '를 입력하세요');
		         $(this).focus();
		         event.preventDefault();
		         return false;
		      }
		   });
		   
		});		
	});

</script>
<div class="card mb-3">
	<div class="card-body position-relative admindefault">
		<div class="row">
			<div class="col-lg-8">
				<h3 class="admindefault">공지사항</h3>
			</div>
		</div>
	</div>
</div>
            <div class="card-body py-2 admindefault">
				<form name="frmWrite" method="post" enctype="multipart/form-data"
				action="<c:url value='${url}'/>">	
				<!-- 수정 처리시 no,oldFileName가 필요하므로 hidden 필드에 넣어서 보내준다 -->
				<input type="hidden" name="no" value="${no}">
				<input type="hidden" name="olddFileName" value="">
					
					<div class="row mb-3 d-flex align-items-center">
					    <div class="col-md-auto">
					        <label class="form-label" for="title">제목</label>
					    </div>
					    <div class="col-md-11">
					        <input type="text" class="form-control admindefault boardbox" id="title" name="title" value="${map['TITLE']}"/>
					    </div>
					</div>
					<div class="row mb-3 d-flex align-items-center">
					    <div class="col-md-auto">
							<label class="form-label" for="">내용</label>
						</div>
						<div class="col-md-11 min-vh-50 align-items-center">
							 <textarea class="tinymce d-none boardbox" data-tinymce="data-tinymce" name="content" value="${map['CONTENT']}" style="color: black;"></textarea>
						</div>
					</div>
					<div class="row mb-3 d-flex align-items-center">
						<div class="col-md-auto adminempdiv3">
							<label class="form-label">첨부 파일</label>
						</div>
						<div class="col-md-4">	 
							<input type="file" class="form-control admindefault"/>
						</div>
					</div>
					<div style="text-align: center;">
					<input type="submit" value="${btLabel}" class="btn btn-primary"/>
					<input type="button" value="취소" class="btn btn-primary"/>
					</div>
				</form>
			</div>
<%@ include file='../../inc/adminBottom.jsp'%>