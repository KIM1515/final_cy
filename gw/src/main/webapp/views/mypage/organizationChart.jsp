<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp"%>
<link rel="stylesheet" href="<c:url value='/css/mypageempform.css'/>">
<div class="row g-0">
	<div class="col-lg-12 pe-lg-2 mb-3">
		<div class="card h-lg-100 overflow-hidden">
			<div class="card-header">
				<h5 class="mb-0">
					<span class="fas fa-user" style="margin: 0 10px;"></span>조직도
				</h5>
			</div>
			<div class="card-body py-2">
              <div class="card" id="allContactTable">
                <div class="card-header border-bottom border-200 px-0">
                  <div class="d-lg-flex justify-content-between">
                  <form name="frmSearch" method="post" action="<c:url value=''/>">
                    <div class="row flex-between-center gy-2 px-x1">
                      <div class="col-auto">
                         <select class="mypageempborder mypageempsel">
							<option value="">부서목록</option>
							<option value="">개발팀</option>
							<option value="">디자인팀</option>
							<option value="">영업팀</option>
							<option value="">회계팀</option>
						</select>
                      </div>
                      <div class="col-auto">
                         <div class="input-group">
                           <input class="form-control shadow-none search" type="search" placeholder="사원번호/이름/부서/직급 검색" aria-label="search" style="width: 280px;"/>
                           <button class="btn btn-sm btn-outline-secondary border-300 hover-border-secondary"><span class="fa fa-search fs--1"></span></button>
                         </div>
                      </div>
                    </div>
                  </form>
				</div>
			</div>
					<div id="organization-chart">
						<div class="mb-3">
							<button class="btn btn-primary" type="button"
								data-bs-toggle="collapse" data-bs-target="#dev-employees">
								<span class="fas fa-plus" data-fa-transform="shrink-3"></span>
							</button>
							<span>개발팀</span>
							<div class="collapse" id="dev-employees">
								<div class="list-group">
								  <a href="#" class="list-group-item list-group-item-action">사원1</a>
								  <a href="#" class="list-group-item list-group-item-action">사원2</a>
								  <a href="#" class="list-group-item list-group-item-action">사원3</a>
								</div>
								<!-- <ul class="list-group list-group-flush">
									<li class="list-group-item">사원1</li>
									<li class="list-group-item">사원2</li>
									<li class="list-group-item">사원3</li>
								</ul> -->
							</div>
						</div>

						<div class="mb-3">
							<button class="btn btn-primary" type="button"
								data-bs-toggle="collapse" data-bs-target="#design-employees">
								<span class="fas fa-plus" data-fa-transform="shrink-3"></span>
							</button>
							<span>디자인팀</span>
							<div class="collapse" id="design-employees">
								<ul class="list-group list-group-flush">
									<li class="list-group-item">사원4</li>
									<li class="list-group-item">사원5</li>
								</ul>
							</div>
						</div>
						<div class="mb-3">
							<button class="btn btn-primary" type="button"
								data-bs-toggle="collapse" data-bs-target="#sales-employees">
								<span class="fas fa-plus" data-fa-transform="shrink-3"></span>
							</button>
							<span>영업팀</span>
							<div class="collapse" id="sales-employees">
								<ul class="list-group list-group-flush">
									<li class="list-group-item">사원6</li>
									<li class="list-group-item">사원7</li>
									<li class="list-group-item">사원8</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="../inc/bottom.jsp"%>