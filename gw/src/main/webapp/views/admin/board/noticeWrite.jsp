<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file='../../inc/adminTop.jsp'%>
<link rel="stylesheet" href="<c:url value='/css/adminempform.css'/>">
<script src="<c:url value='/vendors/ckeditor5/ckeditor.js'/>"></script>
<script src="<c:url value='/vendors/ckeditor5/translations/ko.js'/>"></script>	
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
					    <div class="col-md-auto adminempdiv6">
					        <label class="form-label" for="title">제목</label>
					    </div>
					    <div class="col-md-10">
					        <input type="text" class="form-control admindefault boardbox" id="title" name="title" value="${map['TITLE']}"/>
					    </div>
					</div>
					<div class="row mb-3 d-flex align-items-center">
					    <div class="col-md-auto adminempdiv6">
							<label class="form-label" for="">내용</label>
						</div>
						<div class="col-md-auto col-md-10">
							<textarea id="editor" name="content" value="${map['CONTENT']}"></textarea>
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
			
<!-- CKEditor -->
<script type="text/javascript">
var myEditor;
ClassicEditor
	.create( document.querySelector( '#editor' ), {
		ckfinder: {
	        uploadUrl: '/pds_upload' // 내가 지정한 업로드 url (post로 요청감)
		},
		alignment: {
            options: [ 'left', 'center', 'right' ]
        }
	} )
	.then( editor => {
        console.log( 'Editor was initialized', editor );
        myEditor = editor;
    } )
	.catch( error => {
	    console.error( error );
	} );
</script>

<%@ include file='../../inc/adminBottom.jsp'%>