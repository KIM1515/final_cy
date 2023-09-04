<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file='../inc/top.jsp'%>
<script type="text/javascript">
	function deleteClubBoard() {
		if(confirm("해당 게시물을 삭제하시겠습니까?")){
			location.href = "<c:url value='/club/deleteClubBoard?clubNo=${param.clubNo}&boardNo=${param.boardNo}'/>"
		}
	}
	
	function deleteComment() {
		if(confirm("해당 게시물을 삭제하시겠습니까?")){
			location.href = "<c:url value='/club/deleteComment?clubNo=${param.clubNo}&boardNo=${param.boardNo}'/>"
		}
	}
	$(function(clubBoardNo) {
		var empNo=${sessionScope.empNo!=map['EMP_NO']};
		
		$('#clubReportBtn').click(function() {
			if(confirm('해당 게시글을 신고하시겠습니까?')){
				$.ajax({
			    	url:"<c:url value='/report/reportClubBoardAjax'/>",
			   		type:"get",
			   		dataType:"text",
			   		data:{
			   			clubBoardNo=clubBoardNo
			   		},
			   		success:function(res){
			   			alert(res);
			    	},error:function(xhr, status, error){
			    		alert(status+" : "+error);
			   		}
		   		}); //ajax
			} //if
		});
	});
	
	$(function() {
		$("#delComment").click(function() {
		    var commentNo = $(this).data("comment_no");
		    
		    // Ajax 요청 보내기
		    $.ajax({
		      url: '/club/deleteComment',
		      method: 'POST', // HTTP 요청 메서드 (GET, POST 등)
		      data: {
		        commentNo: commentNo
		      },
		      success: function(response) {
		        // 서버 응답을 처리
		        alert(response.msg); // 서버에서 반환한 메시지를 출력
		        if (response.success) {
		          // 삭제 성공 시 추가 작업 수행
		          // 예를 들어, 페이지 새로고침 또는 리다이렉트
		          window.location.href = response.url; // 리다이렉션
		        }
		      },
		      error: function(xhr, status, error) {
		        // 에러 처리
		        console.error("에러 발생: " + error);
		      }
		    });
		  });
	});
</script>
<div class="card">
	<div class="card-header d-flex flex-between-center">
	<a href="<c:url value='/club/clubBoard?clubNo=${param.clubNo}'/>">
		<button class="btn btn-falcon-default btn-sm" type="button">
			<span class="fas fa-arrow-left">
			</span>
		</button>
	</a>
	<c:if test="${sessionScope.empNo!=map['EMP_NO']}">
		<a href="<c:url value='/report/reportClubBoardAjax?clubNo=${param.clubNo}&clubBoardNo=${param.boardNo}'/>">
			<button class="btn btn-falcon-default btn-sm" id="clubReportBtn" type="button">
				<span class="fas fa-exclamation"></span>
			</button>
		</a>
	</c:if>
		<!-- 로그인한 사원과 게시글 작성자와 같을 경우에만 수정,삭제 버튼이 보임  -->
        <c:if test="${sessionScope.empNo==map['EMP_NO']}">
	        <a href="<c:url value='/club/editClubBoard?clubNo=${param.clubNo }&boardNo=${param.boardNo}'/>">
	           <button class="btn btn-falcon-default btn-sm" id="edit" type="button">
	               <span class="fas fa-pen" ></span>
	           </button>
	        </a>
		    <button onclick="deleteClubBoard()" class="btn btn-falcon-default btn-sm mx-2" type="button">
				<span class="fas fa-trash-alt"></span>
			</button>
       </c:if>
	</div>
		<!-- 본문 -->
		<div class="card mt-3">
                <div class="card-header bg-light">
                  <h5><span class="fas fa-parachute-box me-2"></span><span>${map['TITLE'] }</span></h5>
                </div>
                <div class="card-body">
                  <div class="d-md-flex d-xl-inline-block d-xxl-flex align-items-center justify-content-between mb-x1">
                    <div class="d-flex align-items-center gap-2">
	                    <div class="avatar avatar-2xl">
	                       <div class="avatar-name rounded-circle">
	                          <img src="<c:url value='/images/${map["IMAGE"]}'/>">
	                       </div>
                    	<p class="mb-0">${map['NAME']}</p>
	                    </div>
                    </div>
                    <p class="mb-0 fs--2 fs-sm--1 fw-semi-bold mt-2 mt-md-0 mt-xl-2 mt-xxl-0 ms-5">
                    	<fmt:formatDate value="${map['REGDATE']}" pattern="yyyy-MM-dd"/><span class="mx-1">|</span><span class="fst-italic"><fmt:formatDate value="${map['REGDATE']}" pattern="a h:mm"/></span>
                    </p>
                  </div>
                  <div>
                  <!-- 글 줄바꿈 처리  -->
	              <% pageContext.setAttribute("newLine", "\r\n"); %>
	            	<c:set var="content" value="${fn:replace(map['CONTENT'], newLine, '<br>')}" />
	                  <div id="content">
	                  	 ${content}
	                  </div>
                    <div class="p-x1 bg-light rounded-3 mt-3">
                      <div class="row flex-between-center gx-4 gy-2">
                      	<img src="<c:url value='/pds_upload/${map["FILENAME"] }'/>">
                      </div>
                    </div>
                  </div>
                  <div class="my-5 position-relative text-center">
                    <hr class="position-absolute top-50 border-300 w-100 my-0" /><span class="position-relative bg-white dark__bg-card-dark px-3 z-1">
                      <button class="btn btn-sm btn-outline-secondary rounded-pill border-300 px-lg-5">Comment</button></span>
                  </div>
                  
				<!-- 답변 반복 시작 -->
				<c:forEach var="commtMap" items="${commtList}">
					<div class="d-md-flex d-xl-inline-block d-xxl-flex align-items-center justify-content-between mb-x1">
		            	<div class="d-flex align-items-center gap-2">
		                    <c:if test="${!empty commtMap['IMAGE']}">
			                    <div class="avatar avatar-2xl">
			                       	<img class="rounded-circle" src="<c:url value='/images/${commtMap["IMAGE"]}'/>"  />
			                    </div>
		                    </c:if>
	   	                    <c:if test="${empty commtMap['IMAGE']}">
			                    <div class="avatar avatar-2xl">
			                         <img class="rounded-circle" src="<c:url value='/images/noImage.jpg'/>"  />
			                    </div>
		                    </c:if>
		                    <p class="mb-0"><a class="fw-semi-bold mb-0 text-800" href="../../app/support-desk/contact-details.jsp">${commtMap['NAME']}</a>&nbsp;
		                	<c:if test="${sessionScope.empNo==map['EMP_NO']}">
							    <a href="<c:url value='/club/editComment?commentNo=${commentNo }&clubNo=${param.clubNo }&boardNo=${param.boardNo}'/>">
							       <button class="btn btn-falcon-default btn-sm" id="edit" type="button">
							          <span class="fas fa-pen" ></span>
							       </button>
							    </a>
								<button onclick="deleteComment()" id="delComment" class="btn btn-falcon-default btn-sm mx-2" type="button">
									<span class="fas fa-trash-alt"></span>
								</button>
       						</c:if>
		                </div>
		                  	<p class="mb-0 fs--2 fs-sm--1 fw-semi-bold mt-2 mt-md-0 mt-xl-2 mt-xxl-0 ms-5"><fmt:formatDate value="${commtMap['REGDATE']}" pattern="yyyy-MM-dd"/><span class="mx-1">|</span><span class="fst-italic"><fmt:formatDate value="${commtMap['REGDATE']}" pattern="a h:mm"/></span><span class="fas fa-star ms-2 text-warning"></span></p>
		             </div>
		             
		             <div class="border-bottom mb-5 pb-5">
			              <!-- 글 줄바꿈 처리  -->
		                  <% pageContext.setAttribute("newLine", "\r\n"); %>
		            	  <c:set var="content" value="${fn:replace(commtMap['CONTENT'], newLine, '<br>')}" />
		                  
		                  <div id="content">
		                  	 ${content}
		                  </div>
	                  </div>
	            </c:forEach>
            <!-- 답변 반복 끝 -->
            
            </div>

            <!-- 답변 등록 -->
            <form id="commtentFrm" name="commtentFrm" action="<c:url value='/club/clubComment'/>" method="post">
	            <input name="empNo" type="hidden" value="${sessionScope.empNo}">
            	<input name="clubNo" type="hidden" value="${param.clubNo}">
            	<input name="boardNo" type="hidden" value="${param.boardNo}">
	            
            	<div class="collapse transition-none" id="previewMailForm">
	                  <h5 class="mb-0 p-x1 bg-light">답변 내용</h5>
	                  <div class="border border-y-0 border-200">
	                    <textarea form="commtentFrm" class="form-control" id="exampleFormControlTextarea1" name="content" cols="50" rows="10"></textarea>
	                  </div>
	                  <div class="d-flex align-items-center justify-content-between px-x1 py-3">
	                    <div class="d-flex align-items-center">
	                      <button class="btn btn-primary btn-sm px-4 me-2" type="submit">등록</button>
	                    </div>
	                    <div class="d-flex align-items-center">
	                      <button class="btn btn-light btn-sm" type="button" data-bs-toggle="tooltip" data-bs-placement="top" title="Delete" data-dismiss="collapse">취소</button>
	                    </div>
	                  </div>
	            </div>
	            <div class="card-footer bg-light" id="preview-footer">
	                 <button class="btn btn-falcon-default btn-sm fs--1" type="button" data-bs-toggle="collapse" data-bs-target="#previewMailForm" aria-expanded="false" aria-controls="previewMailForm"><span class="fas fa-reply"></span><span class="d-none d-sm-inline-block ms-1">Comment</span></button>
	            </div>
            </div>
         
       		</form>
            <!-- 답변 등록 끝-->
            </div>
<%@ include file='../inc/bottom.jsp'%>