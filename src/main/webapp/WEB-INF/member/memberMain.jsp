<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>memberMain.jsp</title>
<jsp:include page="/include/bs4.jsp" />
<style>
 @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap');
	body, h2, h4 {
		font-family: 'Noto Sans KR';
	}
</style>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
	<div class="container">
		<h2 class="text-center">주문 내역</h2>
		<table class="table table-hover">
			<tr class="table-dark text-dark">
				<th>주문날짜</th>
				<th>번호</th>
				<th>수령인</th>
				<th>주문상품</th>
				<th>수량</th>
				<th>결제금액</th>
				<th>배송예약날짜</th>
			</tr>
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<tr>
					<td>${vo.orderDate}</td>
					<td>${vo.idx}</a></td>
					<td>${vo.name}</td>
					<td>${vo.alName}</td>
					<td>
						<c:if test="${vo.level > 3}"><font color="red"><b><i class="ri-emotion-unhappy-line"></i>탈퇴신청</b></font>
							<c:if test="${vo.deleteDiff > 30}"><a href="javascript:memberDeleteOk('${vo.idx}')" title="30일경과"><i class="ri-close-circle-fill xIcon"></i></a></c:if>
						</c:if>
						<c:if test="${vo.level <= 3}"><i class="ri-emotion-happy-line"></i>활동중</c:if>
					</td>
					<td>
						<form name="levelForm">
							<select name="level" onchange="levelChange(this)">
								<option value="0/${vo.idx}" ${vo.level==0 ? "selected" : ""}>관리자</option>
								<option value="1/${vo.idx}" ${vo.level==1 ? "selected" : ""}>일반회원</option>
								<option value="2/${vo.idx}" ${vo.level==2 ? "selected" : ""}>VIP</option>
								<option value="3/${vo.idx}" ${vo.level==3 ? "selected" : ""}>VVIP</option>
								<option value="4/${vo.idx}" ${vo.level > 3 ? "selected" : ""}>탈퇴회원</option>
							</select>
						</form>
					</td>
				</tr>
				<c:set var="curScrStartNo" value="${curScrStartNo - 1}" />
			</c:forEach>
			<tr><td colspan="8" class="m-0 p-0"></td></tr>
		</table>
	</div>
		<!-- 블록 페이징 처리 -->
	 <!-- 블록페이지 시작(1블록의 크기를 3개(3Page)로 한다. 1페이지당 3개씩-->
	<br/>
  <div class="text-center">
  	<ul class="pagination justify-content-center">
  		<c:if test="${pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="adminMemberList.ad?level=${level}&pag=1&pageSize=${pageSize}">첫페이지</a></li></c:if> 
	  	<c:if test="${curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="adminMemberList.ad?level=${level}&pag=${(curBlock-1)*blockSize+1}&pageSize=${pageSize}">이전블록</a></li></c:if>
	  	<c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}" varStatus="st">
  	  	<c:if test="${i <= totPage && i == pag}"><li class="page-item active"><a class="page-link bg-secondary" href="adminMemberList.ad?level=${level}&pag=${i}&pageSize=${pageSize}">${i}</a></li></c:if>
  	  	<c:if test="${i <= totPage && i != pag}"><li class="page-item"><a class="page-link text-secondary" href="adminMemberList.ad?level=${level}&pag=${i}&pageSize=${pageSize}">${i}</a></li></c:if>
	  	</c:forEach>
	  	<c:if test="${curBlock < lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="adminMemberList.ad?level=${level}&pag=${(curBlock+1)*blockSize+1}&pageSize=${pageSize}">다음블록</a></li></c:if>
  		<c:if test="${pag < totPage}"><li class="page-item"><a class="page-link text-secondary" href="adminMemberList.ad?level=${level}&pag=${totPage}&pageSize=${pageSize}">마지막페이지</a></li></c:if> 
 		</ul>
  </div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>