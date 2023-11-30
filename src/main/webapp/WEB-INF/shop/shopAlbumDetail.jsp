<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>shopAlbumDetail.jsp</title>
<jsp:include page="/include/bs4.jsp" />
<script>
	'use strict';
	
	function modalView(part, content) {
		$("#myModal #alName").html(part);
		$("#myModal #singer").html(content);
	}
	
	function numCal(type, ths) {
		let inputNum = $(ths).parents("td").find("input[name='num']");
		let cnt = Number(inputNum.val());
		
		 if(type == 'p') {
			 inputNum.val(Number(cnt + 1));
		 }
		 else {
			 if(cnt > 0) inputNum.val(Number(cnt - 1));
		 }
	}
	
</script>
<style>
	a:hover {
		text-decoration: none;
		color: gray;
	}
</style>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
	<div class="container">
		<form name="myform" method="post" action="shopPay.shop" class="was-validated">
			
			<table class="table table-bordered">
				<tr>
					<td style="width:300px"><img src="${vo.photo}"></td>
					<td>
						<h3><i class="ri-album-fill"></i>&nbsp;<b>${vo.alName}</b></h3>
						<div>${vo.singer} | ${fn: substring(vo.relDate, 0,10)}</div>
						<hr/>
						<div>
							<table class="table table-bordered">
								<tr>
									<th>판매가 </th>
									<td><fmt:formatNumber value="${vo.price}" pattern="#,###"/></td>
								</tr>
								<tr>
									<th>할인가 </th>
									<c:set var="salePrice" value="${vo.price - (vo.price * vo.discount / 100)}" />
									<td><span style="font-size:15pt; color:#ff635a"><b><fmt:formatNumber value="${price}" pattern="#,###"/></b></span></td>
								</tr>
								<tr>
									<th>배송비</th>
									<td>유료 (15,000원 이상 무료배송)</td>
								</tr>
							</table>
						</div>
					</td>
					<td>
						<table class="table table-bordered">
							<tr>
								<td><div>수량</div>
									<div class="btn-group btn-group-sm" style="text-align:center; width:150px;">
										<button type="button" onclick="numCal('m', this)" class="btn btn-dark btn-sm">-</button>
									  <input type="text" name="num" value="1" class="form-control form-control-sm text-center w-50"/>
										<button type="button" onclick="numCal('p', this)" class="btn btn-dark btn-sm">+</button>
									</div>
								</td>
							</tr>
							<tr>
								<td><a href="#" onclick="modalView('${vo.alName}','${vo.singer}')" data-toggle="modal" data-target="#myModal" class="btn btn-dark">장바구니</a></td>
							</tr>
							<tr>
								<td><input type="submit" value="구매하기" class="btn btn-dark"></td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<h3>음반 소개</h3>
						<div>${vo.content}</div>
						<br/>
						<h3>수록곡</h3>
						<div>
						<c:set var="varDisc" value="${fn: split(vo.disc, '/')}" />
						<c:forEach var="tempDisc" items="${varDisc}" varStatus="st">
							${tempDisc}<br/>
						</c:forEach> </div>
					</td>
				</tr>
			</table>
			<!-- The Modal -->
	  <div class="modal fade" id="myModal">
	    <div class="modal-dialog modal-dialog-centered">
	      <div class="modal-content">
	      
	        <!-- Modal Header -->
	        <div class="modal-header">
	          <h4 class="modal-title text-center"><b>장바구니에 담겼습니다.</b></h4>
	          <button type="button" class="close" data-dismiss="modal">&times;</button>
	        </div>
	        
	        <!-- Modal body -->
	        <div class="modal-body">
	          <table class="table table-bordered">
	          	<tr><th>앨범명</th><td><span id="alName"></span></td></tr>
	          	<tr><th>가수</th><td><span id="singer"></span></td></tr>
	          </table>
	        </div>
	        
	        <!-- Modal footer -->
	        <div class="modal-footer">
	          <button type="button" class="btn btn-secondary" data-dismiss="modal">바로가기</button>
	          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	        </div>
	        
	      </div>
	    </div>
		</div>
    <input type="hidden" name="alName" value="${vo.alName}" />
	  <input type="hidden" name="singer" value="${vo.singer}" />
    <input type="hidden" name="salePrice" value="${salePrice}" />
	</form>
	</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>