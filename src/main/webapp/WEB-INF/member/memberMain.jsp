<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
	.tbl1 td {
		padding: 10px;
		line-height: 150px;
		text-align: center;
	}
	.tbl2 td {
		padding: 10px;
	}
	.tbl2 {
		line-height: 150px;
	}
	
</style>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
	<div class="container">
		<h2 class="text-center">주문 내역</h2>
		<table class="table table-hover tbl1">
			<tr class="table-dark text-dark text-center">
				<th>주문시간</th>
				<th>주문번호</th>
				<th>수령인</th>
				<th>주문상품</th>
				<th>수량</th>
				<th>결제금액</th>
				<th>배송예약일</th>
			</tr>
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<tr>
					<td>${fn:substring(vo.orderDate, 0,16)}</td>
					<td>${vo.idx}</a></td>
					<td>${vo.name}</td>
					<td class="td1">
						<a href="shopAlbumDetail.shop?idx=${vo.albumIdx}">
						<table class="table table-borderless text-center tbl2">
							<tr>
								<td><img src="${vo.photo}" width="150px"/></td>
								<td>${vo.alName}</td>
								<td>${vo.singer}</td>
							</tr>
						</table>
						</a>
					</td>
					<td>${vo.albumCnt}</td>
					<td>${vo.finalPrice}</td>
					<td>${fn:substring(vo.reservDate, 0,10)}</td>
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