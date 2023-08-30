<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp"%>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
	window.onload = function() {
		const ctx = document.getElementById('myChart');
		
		new Chart(ctx, {
		  type: 'bar',
		  data: {
		    labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
		    datasets: [{
		      label: '# of Votes',
		      data: [12, 19, 3, 5, 2, 3],
		      borderWidth: 1
		    }]
		  },
		  options: {
		    scales: {
		      y: {
		        beginAtZero: true
		      }
		    }
		  }
		});
		
	}
	
</script>



<style type="text/css">
.t-List {
	font-size: 14px;
	text-align: center;
	border-collapse: collapse;
	border-top: 2px solid rgb(200, 200, 200);
	border-bottom: 2px solid rgb(200, 200, 200);
}

.t-List tr {
	border-top: 1px solid rgb(200, 200, 200);
	height: 45px;
}

.t-List tr:hover {
	background-color: rgb(250, 250, 250);
}

.t-List th {
	background-color: rgb(240, 240, 240);
}

.t-List .th-1 {
	width: 180px;
}

.t-List .th-2 {
	width: 630px;
}

.t-List .th-3 {
	width: 810px;
}

.t-List a {
	text-decoration: none;
	color: black;
	cursor: pointer;
}

.t-List span {
	padding: 5px 10px;
	border-radius: 4px;
	border: 1px;
	color: white;
}




.t-List2 {
	font-size: 14px;
	text-align: center;
	border-collapse: collapse;
	border-top: 2px solid rgb(200, 200, 200);
	border-bottom: 2px solid rgb(200, 200, 200);
}

.t-List2 tr {
	border-top: 1px solid rgb(200, 200, 200);
	height: 45px;
}

.t-List2 tr:hover {
	background-color: rgb(250, 250, 250);
}

.t-List2 th {
	background-color: rgb(240, 240, 240);
}

.t-List2 .th-1 {
	width: 180px;
}

.t-List2 .th-2 {
	width: 630px;
}

.t-List2 .th-3 {
	width: 810px;
}

.t-List2 a {
	text-decoration: none;
	color: black;
	cursor: pointer;
}

.t-List2 span {
	padding: 5px 10px;
	border-radius: 4px;
	border: 1px;
	color: white;
}

.att-header {
	width: 100%;
	height: 153px;
	margin: 10px 0;
}

.div-time-btn {
	width: 40%;
	height: 100%;
	float: left;
	min-width: 340px;
}

#now-time {
	font-size: 70px;
}

.div-time-btn form {
	display: inline-block;
}

.btn-sub {
	width: 115px;
	height: 60px;
	background: rgb(117, 144, 194);
	border: none;
	border-radius: 4px;
	color: white;
	font-size: 17px;
}

#button1 {
	margin-right: 25px;
}

.div-stats {
	width: 60%;
	height: 100%;
	align-items: flex-end;
	min-width: 515px;
}

.t-search {
	margin: 20px 0 10px;
	width: 50%;
	margin-right: auto;
	text-align: center;
	border-collapse: collapse;
	border: 2px solid rgb(200, 200, 200);
	min-width: 430px;
}

.t-search tr {
	height: 45px;
}

.t-search-title {
	background-color: rgb(240, 240, 240);
	width: 200px;
}

.t-search input {
	vertical-align: middle;
}

.t-search input[name="date"] {
	height: 30px;
	font-size: 14px;
	border: 1px solid gray;
	border-radius: 4px;
	width: 120px;
	margin-right: 15px;
}

.t-search input[type="submit"] {
	background: white;
	border: 1px solid gray;
	border-radius: 4px;
	width: 55px;
	height: 31px;
	font-size: 14px;
}

.s-container {
	background: white;
	width: 1170px;
	
}


.chart {
    width: 40%;
    float: left;
}

.divSearch {
    float: left;
}

.list1 {
    float: left;
    width: 40%;
}

.list2 {
    clear: both;
    /* width: 100%; */
}

</style>


<div class="s-container">
	<!-- 검색일<input type="text" id="searchDate">  -->
		<!--차트가 그려질 부분-->
		<div class="chart">
			<canvas id="myChart"></canvas>
		</div>
		
		<div class="divSearch">
			<form action="<c:url value='/commute/statistics'/>" method="post">
				<table class="t-search">
					<tr>
						<td class="t-search-title">검색일</td>
						<td><input type="month" id="nowMonth" name="date"> <input
							type="submit" value="검색"></td>
					</tr>
				</table>
			</form>
		</div>
		
		<div class="list1">
			<table class="t-List width1">
				<tr>
					<th colspan="4">통계</th>
				</tr>
				<tr>
					<th class="th-1">출근</th>
					<th class="th-1">지각</th>
					<th class="th-1">조퇴</th>
					<th class="th-1">총 근무시간</th>
				</tr>
				<tr>
					<td>${attendance}</td>
					<td>${late}</td>
					<td>${ealry}</td>
					<td>${TotalWorkTimeOfMonth}<c:if
							test="${!empty TotalWorkTimeOfMonth}">h</c:if></td>
				</tr>
			</table>
		</div>
		
		<div class="list2">
			<table class="t-List2">
				<tr>
					<th class="th-1">날짜</th>
					<th class="th-1">출근시간</th>
					<th class="th-1">퇴근시간</th>
					<th class="th-1">근무시간</th>
					<th class="th-1">근무상태</th>
				</tr>
				<c:forEach var="map" items="${commuteList}">
					<tr>
						<td>${map['workDate']}</td>
						<td>${map['workInTime']}</td>
						<td>${map['workOutTime']}</td>
						<td>${map['workTime']}</td>
						<td>${map['state']}</td>
					</tr>
				</c:forEach>
			</table>
		</div>


</div>



<%@ include file="../inc/bottom.jsp"%>