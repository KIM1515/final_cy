<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file ="../inc/top.jsp"%>    
<link rel="stylesheet"href="<c:url value='/css/mypageempform.css'/>">  
<script type="text/javascript">
	$(function(){
		//직접입력을 선택하면 email3 텍스트 상자가 보이게
		$("#addrbookEmail2").change(function() {
			if ($("#addrbookEmail2").val() == "etc") {
				$("#addrbookEmail3").val("");
				$("#addrbookEmail3").css("visibility", "visible");
				$("#addrbookEmail3").focus();
			}else {
				$("#addrbookEmail3").css("visibility", "hidden");
			}
		});
		
		$('#btnAddrWrite').click(function(){
			var tel1=$('#addrbookTel1').val();
			var tel2=$('#addrbookTel2').val();
			var tel3=$('#addrbookTel3').val();
			
			var tel="";
			if(tel1!=="" && tel2!=="" && tel3!==""){
				tel=tel1+"-"+tel2+"-"+tel3;
			}
			$('#addrbookTel').attr('value',tel);
			
			var email1=$('#addrbookEmail1').val();
			var email2=$('#addrbookEmail2').val();
			var email3=$('#addrbookEmail3').val();
			
			var email="";
			if(email1!==""){
				if(email2==="etc"){
					if(email3!==""){
					email=email1+"@"+email3;
					}
				}else{
					email=email1+"@"+email2;
				}	
			}
			$('#addrbookEmail').attr('value',email);
			
			if($('#addrbookName1').val().length<1){
	            alert("이름을 입력하세요.");
	            $('#addrbookName1').focus();
	            return false;
	         }
			
			if ($('#addrbookTel').val().length < 1) {
				alert("전화번호를 입력하세요.");
				if($('#addrbookTel1').val().length<1){
					$('#addrbookTel1').focus();
				}else if($('#addrbookTel2').val().length<1){
					$('#addrbookTel2').focus();
				}else if($('#addrbookTel3').val().length<1){
					$('#addrbookTel3').focus();
				}
				return false;
			}
			
			if ($('#addrbookEmail').val().length < 1) {
				alert("이메일을 입력하세요.");
				$('#addrbookEmail1').focus();
				return false;
			}
			var addrbookName=$('#addrbookName1').val();
			var addrbookTel=$('#addrbookTel').val();
			var addrbookEmail=$('#addrbookEmail').val();
			var addrbookComname=$('#addrbookComname1').val();
			var addrbookDept=$('#addrbookDept1').val();
			var addrbookRank=$('#addrbookRank1').val();
			
			$.ajax({
	            url : "<c:url value='/mypage/ajaxAddrInsert'/>",
	            type:'get',
	            data: {
	            	addrbookName: addrbookName,
	            	addrbookTel: addrbookTel,
	            	addrbookEmail: addrbookEmail,
	            	addrbookComname: addrbookComname,
	            	addrbookDept: addrbookDept,
	            	addrbookRank: addrbookRank
	            },
	            dataType : 'json',
	            success: function(res){
	            	if(res>0){
		            	alert("주소록 등록이 완료되었습니다.");
		            	$('#staticBackdrop4').modal('hide'); 
	               		location.href="<c:url value='/mypage/addressBook'/>";
	            	}
	            },
	            error:function(xhr, status, error){
	               alert(status+" : "+error);
	            }
	         });//ajax 
		});
		
		$('#btnEdit').click(function(){
			var checkModal=false;
			var count= $('input[type=checkbox]:checked').length;
			if(count==1){
				var addrbookNo=$('input[type=checkbox]:checked').val();
				//alert(addrbookNo);
				$('#staticBackdrop5').modal('show');
				checkModal=true;
				if(checkModal){
					$.ajax({
			            url : "<c:url value='/mypage/ajaxAddrSelect'/>",
			            type:'get',
			            data: {addrbookNo: addrbookNo},
			            dataType : 'json',
			            success: function(res){
			            	$('#addrbookNameDiv').empty();
			            	$('#addrbookTelDiv').empty();
			            	$('#addrbookEmailDiv').empty();
			            	$('#addrbookEmailDiv2').empty();
			            	$('#addrbookComnameDiv').empty();
			            	$('#addrbookDeptDiv').empty();
			            	$('#addrbookRankDiv').empty();
			            	
			            	var receivedData = res;
			            	var addrbookNo=receivedData.addrbookNo;
			            	var addrbookName=receivedData.addrbookName;
			            	var addrbookTel=receivedData.addrbookTel;
		            	 	var str=addrbookTel.split("-");
			    			var tel1=str[0];
			    			var tel2=str[1];
			    			var tel3=str[2];
			            	var addrbookEmail=receivedData.addrbookEmail;
			             	var str2=addrbookEmail.split("@");
			    			var email1=str2[0];
			    			var email2=str2[1];
			    			var addrbookComname=receivedData.addrbookComname;
			    			var addrbookDept=receivedData.addrbookDept;
			    			var addrbookRank=receivedData.addrbookRank;
			    			
			            	//모달 수정창
							var result="<input class='form-control' value='"+addrbookName+"' id='addrbookName2' name='addrbookName' type='text'/>";
							$('#addrbookNameDiv').append(result);
							
							var result2="<input type='text' class='form-control' value='"+tel1+"' id='2addrbookTel1' style='width: 30%;' maxlength='3'/>"
			            	+"<span class='mypagehyphen'>-</span>"
			            	+"<input type='text' class='form-control' value='"+tel2+"' id='2addrbookTel2' style='width: 30%;' maxlength='4' />"
			            	+"<span class='mypagehyphen'>-</span>"
			            	+"<input type='text' class='form-control' value='"+tel3+"' id='2addrbookTel3' style='width: 30%;' maxlength='4' />"
							$('#addrbookTelDiv').prepend(result2);
			            	
			            	var result3="<input type='text' value='"+email1+"' class='form-control' id='2addrbookEmail1' style='width: 38%'>"
			            	+"<span class='mypagehyphen'>@</span>"
			            	+"<select class='form-select' value='"+email2+"' id='2addrbookEmail2' title='이메일주소 뒷자리' style='width: 55%'>"
			            	+"<option value='naver.com'>naver.com</option><option value='hanmail.net'>hanmail.net</option>"
			           		+"<option value='nate.com'>nate.com</option><option value='gmail.com'>gmail.com</option>"
			            	+"<option value='etc'>직접입력</option></select>";
			            	$('#addrbookEmailDiv').append(result3);
			            	
			            	var result0="<input type='text' id='2addrbookEmail3' class='form-control' title='직접입력인 경우 이메일주소 뒷자리' style='visibility: hidden;'>";
			            	$('#addrbookEmailDiv2').prepend(result0);
			            	
			            	$("#2addrbookEmail2").change(function() {
			        			if ($("#2addrbookEmail2").val() == "etc") {
			        				$("#2addrbookEmail3").val("");
			        				$("#2addrbookEmail3").css("visibility", "visible");
			        				$("#2addrbookEmail3").focus();
			        			}else {
			        				$("#2addrbookEmail3").css("visibility", "hidden");
			        			}
			        		});
			            	
			            	var result4="<input class='form-control' value='"+addrbookComname+"' id='addrbookComname2' name='addrbookComname' type='text' />";
			            	$('#addrbookComnameDiv').append(result4);
			            	
			            	var result5="<input class='form-control' value='"+addrbookDept+"' id='addrbookDept2' name='addrbookDept' type='text' />";
			            	$('#addrbookDeptDiv').append(result5);
			            	
			            	var result6="<input class='form-control' value='"+addrbookRank+"' id='addrbookRank2' name='addrbookRank' type='text'/>"
			            	+"<input type='hidden' value='"+addrbookNo+"' id='addrbookNo2'>";
			            	$('#addrbookRankDiv').append(result6);
				            	
			            
			            },
			            error:function(xhr, status, error){
			               alert(status+" : "+error);
			            }
			         });//ajax 
					}//if
			}else if(count<1){
				alert('수정할 주소록을 체크 바랍니다.');
			}else if(count>1){
				alert('수정할 주소록을 하나만 체크 바랍니다.');
			}
		});
		
		$('#btnAddrEdit').click(function(){
			var tel1=$('#2addrbookTel1').val();
			var tel2=$('#2addrbookTel2').val();
			var tel3=$('#2addrbookTel3').val();
			
			var tel="";
			if(tel1!=="" && tel2!=="" && tel3!==""){
				tel=tel1+"-"+tel2+"-"+tel3;
			}
			$('#addrbookTel').attr('value',tel);
			
			var email1=$('#2addrbookEmail1').val();
			var email2=$('#2addrbookEmail2').val();
			var email3=$('#2addrbookEmail3').val();
			
			var email="";
			if(email1!==""){
				if(email2==="etc"){
					if(email3!==""){
					email=email1+"@"+email3;
					}
				}else{
					email=email1+"@"+email2;
				}	
			}
			$('#addrbookEmail').attr('value',email);
			
			if($('#addrbookName2').val().length<1){
	            alert("이름을 입력하세요.");
	            $('#addrbookName2').focus();
	            return false;
	         }
			
			if ($('#addrbookTel').val().length < 1) {
				alert("전화번호를 입력하세요.");
				if($('#2addrbookTel1').val().length<1){
					$('#2addrbookTel1').focus();
				}else if($('#2addrbookTel2').val().length<1){
					$('#2addrbookTel2').focus();
				}else if($('#2addrbookTel3').val().length<1){
					$('#2addrbookTel3').focus();
				}
				return false;
			}
			
			if ($('#addrbookEmail').val().length < 1) {
				alert("이메일을 입력하세요.");
				$('#2addrbookEmail1').focus();
				return false;
			}
			
			var addrbookNo=$('#addrbookNo2').val();
			var addrbookName=$('#addrbookName2').val();
			var addrbookTel=$('#addrbookTel').val();
			var addrbookEmail=$('#addrbookEmail').val();
			var addrbookComname=$('#addrbookComname2').val();
			var addrbookDept=$('#addrbookDept2').val();
			var addrbookRank=$('#addrbookRank2').val();
			
			$.ajax({
	            url : "<c:url value='/mypage/ajaxAddrUpdate'/>",
	            type:'get',
	            data: {
	            	addrbookNo: addrbookNo,
	            	addrbookName: addrbookName,
	            	addrbookTel: addrbookTel,
	            	addrbookEmail: addrbookEmail,
	            	addrbookComname: addrbookComname,
	            	addrbookDept: addrbookDept,
	            	addrbookRank: addrbookRank
	            },
	            dataType : 'json',
	            success: function(res){
	            	if(res>0){
		            	alert("주소록 수정이 완료되었습니다.");
		            	$('#staticBackdrop5').modal('hide'); 
	               		location.href="<c:url value='/mypage/addressBook'/>";
	            	}
	            },
	            error:function(xhr, status, error){
	               alert(status+" : "+error);
	            }
	         });//ajax 
		});
		
		$('#btnDel').click(function(){
			var count= $('input[type=checkbox]:checked').length;
			var addrbookNo=$('input[name=addrbookNo]').val();
		
			alert(count+":"+addrbookNo);
			
			if(count<1){
				alert('삭제하고 싶은 주소록을 먼저 체크하세요');
			}
			
			if(count>0){
				if(confirm('선택한 게시글을 삭제하시겠습니까?')){
					$('form[name=frmList]').prop('action', "<c:url value='/mypage/addressBook/DeleteMulti'/>");
					$('form[name=frmList]').submit();
				} // if
			} 
		});
		
	});


	function pageFunc(curPage){
		$('input[name="currentPage"]').val(curPage);
		$('form[name="frmPage"]').submit();
	}
	
	function submitForm() {
	    document.getElementById('frmSearch').submit();
	}
</script>
 <!-- 페이징 처리 관련 form -->
		<form action="<c:url value='/mypage/addressBook'/>" 
			name="frmPage" method="post">
			<input type="hidden" name="currentPage">
			<input type="hidden" name="searchKeyword" value="${param.searchKeyword}">
			<input type="hidden" name="searchCondition" value="${param.searchCondition}">
		</form>  
<div class="row g-0">
   <div class="col-lg-12 pe-lg-2 mb-3">
       <div class="card h-lg-100 overflow-hidden">
			<div class="card-header ">
				<h5 class="mb-0 ">
					<span class="fas fa-phone" style="margin: 0 10px;"></span>주소록
				</h5>
			</div>
			<div class="card-body py-2 ">
				<div class="card" id="allContactTable">
					<div class="card-header border-bottom border-200 px-0 ">
						<div class="d-lg-flex justify-content-between">
							<form name="frmSearch" method="post" action="<c:url value='/mypage/addressBook'/>">
								<div class="row flex-between-center gy-2 px-x1">
									<div class="col-auto pe-0 ">
										<select class=" mypageempborder mypageempsel">
											 <option value="addrbookName"
				                            	<c:if test="${param.searchCondition=='addrbookName'}">
				                            		selected = "selected"
				                            	</c:if>
				                            >이름</option>
				                            <option value="addrbookComname"
				                            	<c:if test="${param.searchCondition=='addrbookComname'}">
				                            		selected= "selected"
				                            	</c:if>
				                            >회사명</option>		
				                            <option value="addrbookTel"
			                       		        <c:if test="${param.searchCondition=='addrbookTel'}">
				                            		selected = "selected"
				                            	</c:if>
				                            >전화번호</option>
										</select>
									</div>
									<div class="col-auto">
										<div class="input-group input-search-width ">
											<input class="form-control shadow-none search "
												type="search" placeholder="검색어 입력" aria-label="search" />
											<button
												class="btn btn-sm btn-outline-secondary border-300 hover-border-secondary">
												<span class="fa fa-search fs--1"></span>
											</button>
										</div>
									</div>
									 <div class="col-auto searchEmpResult" style="padding: 10px 0 0 25px;">
										<c:if test="${!empty param.searchKeyword }">
										   <p>검색어 : ${param.searchKeyword} , <span style="font-weight: bold; color: red;">${pagingInfo.totalRecord}</span> 건 검색되었습니다.</p>
										</c:if>   
									</div>
								</div>
							</form>
						<div class="border-bottom border-200 my-3"></div>
							<div class="d-flex align-items-center justify-content-between justify-content-lg-end px-x1 ">
								<div class="d-flex align-items-center "
									id="table-contact-replace-element">
									 <button class="btn btn-falcon-default btn-sm" type="button"
									 	data-bs-toggle="modal" data-bs-target="#staticBackdrop4">
										 <span class="fas fa-plus" data-fa-transform="shrink-3"></span>
										 <span class="d-none d-sm-inline-block d-xl-none d-xxl-inline-block ms-1">연락처 추가</span>
									 </button>
									<button class="btn btn-falcon-default btn-sm mx-2" id="btnEdit" type="button">
										<span class="fas fa-external-link-alt"
											data-fa-transform="shrink-3"></span><span
											class="d-none d-sm-inline-block d-xl-none d-xxl-inline-block ms-1">연락처 수정</span>
									</button>
									<button class="btn btn-falcon-default btn-sm"
										type="button" id="btnDel">
										<span class="fas fa-file-import" data--transform="shrink-3"></span><span
											class="d-none d-sm-inline-block d-xl-none d-xxl-inline-block ms-1">연락처 삭제</span>
									</button>
								</div>
							</div>
						</div>
					</div>
						
					<div class="card-body p-0 ">
					 <div class="table-responsive scrollbar">
                    <table class="table table-sm table-hover">
						<colgroup>
							<col style="width:5%;" />
							<col style="width:15%;" />
							<col style="width:20%;" />
							<col style="width:15%;" />
							<col style="width:15%;" />
							<col style="width:15%;" />	
							<col style="width:15%;" />	
						</colgroup>
                      <thead class="adminempthead">
                        <tr style="text-align: center;">
                          <th class="py-2 fs-0 pe-2" style="width: 28px;">
                            <div class="form-check d-flex align-items-center">
                              <input class="form-check-input" id="checkbox-bulk-tickets-select" type="checkbox" data-bulk-select='{"body":"table-contact-body","actions":"table-contact-actions","replacedElement":"table-contact-replace-element"}' />
                            </div>
                          </th>
                          <th class="sort align-middle" scope="col">이름</th>
                          <th class="sort align-middle" scope="col">전화번호</th>
                          <th class="sort align-middle" scope="col">이메일</th>
                          <th class="sort align-middle" scope="col">회사</th>
                          <th class="sort align-middle" scope="col">부서</th>
                          <th class="sort align-middle" scope="col">직급</th>
                        </tr>
                      </thead>
                      <tbody id="table-contact-body">
                      <c:if test="${empty list }">
                      	<tr class="mypageemptr">
                      		<th colspan="7">없음</th>
                      	</tr>
                      </c:if>
                      <c:if test="${!empty list }">
                       <c:set var="idx" value="0"/>
                       	<form name="frmList">
                      <c:forEach var="addressBookVo" items="${list }">
	                        <tr class="mypageemptr">
	                          <td class="align-middle fs-0 py-3 align-middle">
	                            <div class="form-check mb-0">
	                              <input class="form-check-input" value="${addressBookVo.addrbookNo }" type="checkbox"
	                             	 name="addrItems[${idx}].addrbookNo"/>
	                            </div>
	                          </td>
	                          <td class="align-middle">${addressBookVo.addrbookName }</td>
	                          <td class="align-middle">${addressBookVo.addrbookTel }</td>
	                          <td class="align-middle">${addressBookVo.addrbookEmail }</td>
	                          <td class="align-middle">${addressBookVo.addrbookComname }</td>
	                          <td class="align-middle">${addressBookVo.addrbookDept }</td>
	                          <td class="align-middle">${addressBookVo.addrbookRank }</td>
	                        </tr>
                        <c:set var="idx" value="${i+1 }"/>
                        </c:forEach>
                     	</form>
                         </c:if>
                      </tbody>
                    </table>
                    <div class="text-center d-none" id="contact-table-fallback">
                      <p class="fw-bold fs-1 mt-3">No contact found</p>
                    </div>
                  </div>
                </div>
                <div class="card-footer d-flex justify-content-center">
                  <div class="divPage" id="divPage">
				<!-- 페이지 번호 추가 -->		
				<!-- 이전 블럭으로 이동 -->
				<c:if test="${pagingInfo.firstPage>1 }">
					<a href="#" id="prevPage" onclick="pageFunc(${pagingInfo.firstPage-1})">
						<img src="<c:url value='/images/first.JPG'/>">
					</a>
				</c:if>	
								
				<!-- [1][2][3][4][5][6][7][8][9][10] -->
				<c:forEach var="i" begin="${pagingInfo.firstPage }" end="${pagingInfo.lastPage }">		
					<c:if test="${i == pagingInfo.currentPage }">		
						<span id="curPage">${i}</span>
			        	</c:if>
					<c:if test="${i != pagingInfo.currentPage }">		
				         <a href="#" id="otherPage" onclick="pageFunc(${i})">${i}</a>
				    </c:if>   		
				</c:forEach>
				
				<!-- 다음 블럭으로 이동 -->
				<c:if test="${pagingInfo.lastPage < pagingInfo.totalPage }">
			         <a href="#" id="nextPage" onclick="pageFunc(${pagingInfo.lastPage+1})">
						<img src="<c:url value='/images/last.JPG'/>">
					</a>
				</c:if>
				<!--  페이지 번호 끝 -->
			</div>
				</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="addressBookModal.jsp" %>
<%@ include file ="../inc/bottom.jsp"%>