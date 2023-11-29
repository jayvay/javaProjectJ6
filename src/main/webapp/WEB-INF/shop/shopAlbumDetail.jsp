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
</script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
	<div class="container">
		<table class="table table-border">
			<tr>
				<td><img src="${vo.photo}"></td>
				<td>
					<h3><i class="ri-album-fill"></i>&nbsp;<b>${vo.alName}</b></h3>
					<div>${vo.singer} | ${fn: substring(vo.relDate, 0,10)}</div>
					<hr/>
					<div>
						<table>
							<tr>
								<th>판매가 </th>
								<td><fmt:formatNumber value="${vo.price}" pattern="#,###"/></td>
							</tr>
							<tr>
								<th>할인가 </th>
								<c:set var="price" value="${vo.price - (vo.price * 20 / 100)}" />
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
					<table>
						<tr>
							<td><a href="#" onclick="modalView('${vo.alName}','${vo.singer}')" data-toggle="modal" data-target="#myModal" class="btn btn-dark">장바구니</a></td>
						</tr>
						<tr>
							<td>수량<input name="num" id="num" type="number" value="1" min="1" max="10" maxlength="2" /></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
			<hr/>
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
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>