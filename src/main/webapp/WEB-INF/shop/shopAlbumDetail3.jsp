<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine", "\n"); %>
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
		$("#myModal #num").html($("#num").val());
		myForm.action = "shopCart.shop";
		myForm.submit();
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
	
	//장바구니
	function cartSave() {

		let albumIdx = ${vo.idx};
		let num = myForm.num.value;
		let salePrice = ${salePrice};
		
		let query = {
				albumIdx : albumIdx,
				num : num,
				salePrice : salePrice
		}
		
		$.ajax({
			url : "shopCart.shop",
			type : "post",
			data : query,
			success : function(res) {
				if(res != "1") alert("장바구니 저장 완료");
				else alert("장바구니 저장 실패, 다시 시도하세요");
			},
			error : function() {
				alert("전송 오류");
			}
		});
		
		$("#demo").html(modalView('${vo.alName}','${vo.singer}') data-toggle="modal" data-target="#myModal");
	}
	
	function shopCartCheck() {
		myForm.action = "shopCartList.shop";
		myForm.submit();
	}
	
	 //댓글 등록
	 function reviewCheck() {
		  let star = starForm.star.value;
			let content = $("#content").val();
			
			if(star.trim() == "") {
				alert("별점을 부여해주세요.");
				return false;
			}
			if(content.trim() == "") {
				alert("리뷰를 입력하세요");
				$("#content").focus();
				return false;
			}
	  	
			let query = {
					albumIdx : ${vo.idx},
					mid : '${sMid}',
					nickName : '${sNickName}',
					content : content,
					star : star
			}
			
	  	$.ajax({
				url : "albumReviewInput.shop",
				type : "post",
				data : query,
				success : function(res) {
					if(res == "1") {
						alert("리뷰가 입력되었습니다.");
						location.reload();
					}
					else {
						alert("리뷰 입력 실패~");
					}
				},
				error : function() {
					alert("전송 오류");
				}
				
			});
		}
	
	//댓글 삭제
  function reviewDelete(idx) {
			let ans = confirm("선택한 리뷰를 삭제하시겠습니까?");
			if(!ans) return false;
			
			$.ajax ({
				url : "albumReviewDelete.shop",
				type : "post",
				data : {idx : idx},
				success : function(res) {
					if(res == "1") {
						alert("리뷰가 삭제되었습니다.");
						location.reload();
					}
					else alert("리뷰 삭제 실패");
				},
				error : function() {
					alert("전송 실패")
				}
			});
		}
</script>
<style>
 @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap');
 	body {
		font-family: 'Noto Sans KR';
	}
	a:hover {
		text-decoration: none;
		color: gray;
	}
	#starForm fieldset {
		direction : rtl;	/* rtl : '~'를 거꾸로 뒤집기 (54321 => 12345)*/
	}
	
	#starForm input[type=radio] {
		display : none;
	}
	
	#starForm label {
		font-size : 1.6em;
		color : transparent;
		text-shadow : 0 0 0 #cccccc;
	}

	#starForm label:hover {
		text-shadow : 0 0 0 rgba(250, 200, 0 , 0.95);
	}
	
	#starForm label:hover ~ label {	/* '~' : 다음(형제 이후)을 선택하는 선택자 */
		text-shadow : 0 0 0 rgba(250, 200, 0 , 0.95);
	}
	
	#starForm input[type=radio]:checked ~ label {
		text-shadow : 0 0 0 rgba(250, 200, 0 , 0.95);
	}
	
	.ri-star-fill, .ri-star-line {
		margin: 5pt;
		font-size: 30pt;
		color: #669acc;
	}
	.col {
		line-height: 30pt;
	}
	#reviewGrid {
		border: 0px;
		margin: 0px;
		padding: 0px;
	}
	.tbl1 td {
		width: 100%;
	}
	.tbl3 th {
		width: 20%;
	}
	.tbl3 td {
		width: 80%;
	}
	.tbl2 {
		width: 100%;
		height: 200px;
		background-color: #eee;
	}
	.btn-lg {
		width: 100px;
		height: 80px;
		font-weight: bold;
	}
</style>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
	<div class="container">
		<form name="myForm" method="post" action="shopPay.shop">
			
			<table class="table table-bordered tbl1">
				<tr>
					<td style="width:300px"><img src="${vo.photo}"></td>
					<td>
						<h3><i class="ri-album-fill"></i>&nbsp;<b>${vo.alName}</b></h3>
						<div>${vo.singer} | ${fn: substring(vo.relDate, 0,10)}</div>
						<hr/>
						<div>
							<table class="table table-bordered tbl3">
								<c:if test="${vo.stock > 0}">
									<tr>
										<th>판매가 </th>
										<td><fmt:formatNumber value="${vo.price}" pattern="#,###"/></td>
									</tr>
									<tr>
										<th>할인가 </th>
										<c:set var="salePrice" value="${vo.price - (vo.price * vo.discount / 100)}" />
										<td><span style="font-size:15pt; color:#ff635a"><b><fmt:formatNumber value="${salePrice}" pattern="#,###"/></b></span></td>
									</tr>
								</c:if>
								<c:if test="${vo.stock == 0}">
									<tr>
										<th>판매가 </th>
										<td><font color="red">품절</font></td>
									</tr>
								</c:if>
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
									  <input type="text" name="num" id="num" value="1" readonly class="form-control form-control-sm text-center w-50"/>
										<button type="button" onclick="numCal('p', this)" class="btn btn-dark btn-sm">+</button>
									</div>
								</td>
							</tr>
							<c:if test="${vo.stock > 0}">
								<tr>
									<td>
										<a href="#" onclick="cartSave()" class="btn btn-dark">장바구니</a>
										<span id="demo"></span>
									</td>
								</tr>
								<tr>
									<td><input type="submit" value="구매하기" class="btn btn-dark"></td>
								</tr>
							</c:if>
							<c:if test="${vo.stock == 0}">
								<tr>
									<td>구매불가</td>
								</tr>
							</c:if>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<h3>음반 소개</h3>
						<div>${fn:replace(vo.content, newLine, '<br/>')}</div>
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
	          	<tr><th>수량</th><td><span id="num"></span></td></tr>
	          </table>
	        </div>
	        
	        <!-- Modal footer -->
	        <div class="modal-footer">
	          <button type="button" class="btn btn-secondary" onclick="shopCartCheck()" data-dismiss="modal">바로가기</button>
	          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	        </div>
	        
	      </div>
	    </div>
		</div>
    <input type="hidden" name="albumIdx" value="${vo.idx}" />
    <input type="hidden" name="alName" value="${vo.alName}" />
    <input type="hidden" name="singer" value="${vo.singer}" />
    <input type="hidden" name="salePrice" value="${salePrice}" />
	</form>
	<hr/>
		<!-- 댓글 -->
		<div class="container"><h4><b>별점/리뷰</b></h4>
			<!-- 별점 -->
		<div>
			<form name="starForm" id="starForm">
			<div class="row">
				<div class="col"></div>
				<div class="col col-4"><font size="5"><b>평균별점</b>(<fmt:formatNumber value="${reviewAvg}" pattern="#,##0.0" /> / 5.0)</font></div>
				<div class="col col-4">
					<c:set var="avgStar" value="${fn:substring(reviewAvg, 0,1)}"/>
					<c:if test="${avgStar == 5}">
						<c:forEach var="i" begin="0" end="${avgStar-1}" varStatus="st"><i class="ri-star-fill"></i></c:forEach>
					</c:if>
					<c:if test="${avgStar == 4}">
						<c:forEach var="i" begin="0" end="${avgStar-1}" varStatus="st"><i class="ri-star-fill"></i></c:forEach>
						<c:forEach var="i" begin="0" end="${4-avgStar}" varStatus="st"><i class="ri-star-line"></i></c:forEach>
					</c:if>
					<c:if test="${avgStar == 3}">
						<c:forEach var="i" begin="0" end="${avgStar-1}" varStatus="st"><i class="ri-star-fill"></i></c:forEach>
						<c:forEach var="i" begin="0" end="${4-avgStar}" varStatus="st"><i class="ri-star-line"></i></c:forEach>
					</c:if>
					<c:if test="${avgStar == 2}">
						<c:forEach var="i" begin="0" end="${avgStar-1}" varStatus="st"><i class="ri-star-fill"></i></c:forEach>
						<c:forEach var="i" begin="0" end="${4-avgStar}" varStatus="st"><i class="ri-star-line"></i></c:forEach>
					</c:if>
					<c:if test="${avgStar == 1}">
						<c:forEach var="i" begin="0" end="${avgStar-1}" varStatus="st"><i class="ri-star-fill"></i></c:forEach>
						<c:forEach var="i" begin="0" end="${4-avgStar}" varStatus="st"><i class="ri-star-line"></i></c:forEach>
					</c:if>
					<c:if test="${avgStar == 0}">
						<c:forEach var="i" begin="0" end="4" varStatus="st"><i class="ri-star-line"></i></c:forEach>
					</c:if>
				</div>
				<div class="col-1"></div>
			</div>
				<!-- 댓글 입력창 -->
				<table class="table table-center tbl2">
					<tr>
						<td style="width:85%" class="text-left">
							<b>별점/리뷰 작성</b> 
							<fieldset id="reviewGrid">
								<div class="text-left">
									<input type="radio" name="star" value="5" id="star1" ><label for = "star1">★</label>
									<input type="radio" name="star" value="4" id="star2" ><label for = "star2">★</label>
									<input type="radio" name="star" value="3" id="star3" ><label for = "star3">★</label>
									<input type="radio" name="star" value="2" id="star4" ><label for = "star4">★</label>
									<input type="radio" name="star" value="1" id="star5" ><label for = "star5">★</label>
								</div>
							</fieldset>
							<textarea rows="4" name="content" id="content" class="form-control"></textarea>
						</td>
						<td style="width:15%">
							<br/>
							<p style="font-size:14px"><b>작성자</b><br/> ${sNickName}</p>
							<p><input type="button" value="등록" onclick="reviewCheck()" class="btn btn-secondary btn-lg" /></p>
						</td>
					</tr>
				</table>
			</form>
		</div>
			<!-- 댓글 리스트 보여주기 -->
			<table class="table table-hover text-center">
				<tr>
					<th>별점</th>
					<th class="text-left">내용</th>
					<th>작성자</th>
					<th>날짜</th>
				</tr>
				<c:forEach var="reviewVo" items="${reviewVos}" varStatus="st">
					<tr>
						<td>
							<c:forEach var="i" begin="1" end="${reviewVo.star}" varStatus="iSt">
								<font color="gold">★</font>
							</c:forEach>
							<c:forEach var="i" begin="1" end="${5-reviewVo.star}" varStatus="iSt"><font color="gray">☆</font></c:forEach>
						</td>
						<td class="text-left">${fn: replace(reviewVo.content, newLine, "<br/>")}</td>
						<td>${reviewVo.nickName}
							<c:if test="${reviewVo.mid == sMid || sLevel == 0}">
								<a href="javascript:reviewDelete(${reviewVo.idx})"><font color="red"><i class="ri-delete-bin-fill"></font></i></a>
							</c:if>
						</td>
						<td>${fn: substring(reviewVo.wDate, 0,10)}</td>
					</tr>
					<tr><td colspan="4" class="m-0 p-0"></td></tr>
				</c:forEach>
			</table>
		</div>	 
	</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>