<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp" %>
<!DOCTYPE html>
<html data-bs-theme="light" lang="en-US" dir="ltr">

  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">


    <!-- ===============================================-->
    <!--    Document Title-->
    <!-- ===============================================-->
    <title>create CLUB</title>

 
  	<body>
		<form name="createFrm" action="<c:url value='/club/createClub'/>" method="post">
          <div class="card mb-3">
            <div class="card-body">
              <div class="row flex-between-center">
                <div class="col-md">
                  <h5 class="mb-2 mb-md-0">동호회 개설</h5>
                </div>
                <div class="col-auto">
                   <label class="form-check-label mb-0" for="basic-checkbox">회원 수 제한</label>
                   <select class="form-select form-select-sm" name="memLimitflag" id="memLimitflag">
                        <option value="Y">제한</option>
                        <option value="N">비제한</option>
                   </select>
                </div>
                <div class="col-auto">
                  <button class="btn btn-falcon-default btn-sm me-2" type="submit">저장</button>
                </div>
              </div>
            </div>
          </div>
          <div class="row g-0">
              <div class="card mb-3">
                <div class="card-header">
                  <h5 class="mb-0">Club Details</h5>
                </div>
                <div class="card-body bg-light">
                    <div class="row gx-2">
                    <div class="col-sm-6 mb-3">
                        <label class="form-label" for="managr">동호회장</label>
                        <input class="form-control" id="manager" name="manager"  type="text" placeholder="Manager" />
                      </div>
                      <div class="col-sm-4 mb-3">
                        <label class="form-label" for="memberCnt">모집 회원 수</label>
                        <input class="form-control" id="memberCnt" name="memLimit" type="text" />
                      </div>
                      <div class="col-12 mb-3">
                        <label class="form-label" for="title">동호희 이름</label>
                        <input class="form-control" id="title" name="title" type="text" placeholder="Club Title" />
                      </div>
                      <div class="col-12 mb-3">
                        <label class="form-label" for="introduce">동호회 소개</label>
                        <input class="form-control" id="introduce" name="introduce" type="text" placeholder="Introduce" />
                      </div>
                      <div class="col-sm-6 mb-3">
                        <label class="form-label" for="secflag">공개 여부</label>
                        <select class="form-select form-select-sm" name="secflag" id="secflag">
                          <option value="Y">공개</option>
                          <option value="N">비공개</option>
                        </select>
                      </div>
                      <div class="col-12">
                        <div class="border-bottom border-dashed my-3"></div>
                      </div>
                    </div>
                </div>
              </div>
          </div>
          <div class="card mt-3">
            <div class="card-body">
              <div class="row justify-content-between align-items-center">
                <div class="col-md">
                  <h5 class="mb-2 mb-md-0"></h5>
                </div>
              </div>
            </div>
          </div>
	</form>
    
    </body>
    </html>
    
<%@ include file="../inc/bottom.jsp" %>