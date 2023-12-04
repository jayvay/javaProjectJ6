<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>shopMain.jsp</title>
<jsp:include page="/include/bs4.jsp" />
<style>
	body, h2, h5 {
	  font-family: Arial, Helvetica, sans-serif;
	}
	
	* {
	  box-sizing: border-box;
	}
	
	/* Create a column layout with Flexbox */
	.row {
	  display: flex;
	}
	
	/* Left column (menu) */
	.left {
	  flex: 5%;
	  padding: 15px 0;
	}
	
	.left h2 {
	  padding-left: 8px;
	}
	
	/* Right column (page content) */
	.right {
	  flex: 65%;
	  padding: 15px;
	}
	
	/* Style the navigation menu inside the left column */
	#myMenu {
	  list-style-type: none;
	  padding: 0;
	  margin: 0;
	}
	
	#myMenu li a {
	  padding: 12px;
	  text-decoration: none;
	  color: black;
	  display: block
	}
	
	#myMenu li a:hover {
	  background-color: #eee;
	}
	img {
		margin:12px;
	}
	img:hover {
	  background-color: gray;
	  opacity : 0.7;
	}
	a:hover {
	  color : green;
  }
  .tbl1 {
  	text-align: center;
  	width: 800px;
  }
</style>
<script>
	'use strict';
	
	function alDeleteCheck(idx, alName, singer) {
    	$("#myModal #idx").val(idx);
    	$("#myModal #alName").html(alName);
    	$("#myModal #singer").html(singer);
	}  	
 		
	function albumDeleteOk() { 	
		let idx = $("#myModal #idx").val();
	  	let pwd = $("#myModal #pwd").val();
  	
		let query = {
				idx : idx,
				pwd : pwd
		}
		
		$.ajax({
			url : "adminAlbumDeleteOk.ad",
			type : "post",
			data : query,
			success : function(res) {
				if(res == "1") {
					alert("앨범이 삭제되었습니다.");
					location.reload();
				} 
				else alert("앨범 삭제 실패, 다시 시도하세요.");
			},
			error : function() {
				alert("전송 오류");
			}
		});
	}
	
	function pageSizeCheck() {
		let pageSize = $("#pageSize").val();
		location.href = "pdsList.pds?part=${part}&pageSize="+pageSize;
	}
</script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
	<div style="margin:0 100px">
		<div class="row">
		  <div class="left" style="background-color:#bbb;">
		    <h2>Menu</h2>
		    <ul id="myMenu" style="text-align:center">
		      <li><a href="shopMain.shop?part=all&pag=${pag}&pageSize=${pageSize}">ALL</a></li>
		      <li><a href="shopMain.shop?part=1/kBallad&pag=${pag}&pageSize=${pageSize}">BALLAD</a></li>
		      <li><a href="shopMain.shop?part=1/kDance&pag=${pag}&pageSize=${pageSize}">DANCE</a></li>
		      <li><a href="shopMain.shop?part=1/kRock&pag=${pag}&pageSize=${pageSize}">ROCK</a></li>
		      <li><a href="shopMain.shop?part=1/kSoul&pag=${pag}&pageSize=${pageSize}">R&B</a></li>
		      <li><a href="shopMain.shop?part=1/kIndi&pag=${pag}&pageSize=${pageSize}">INDI</a></li>
		      <li><a href="shopMain.shop?part=1/kHiphop&pag=${pag}&pageSize=${pageSize}">HIPHOP</a></li>
		      <li><a href="shopMain.shop?part=2/wPop&pag=${pag}&pageSize=${pageSize}">POP</a></li>
		      <li><a href="shopMain.shop?part=2/wJPop&pag=${pag}&pageSize=${pageSize}">J-POP</a></li>
		      <li><a href="shopMain.shop?part=3/movie&pag=${pag}&pageSize=${pageSize}">MOVIE OST</a></li>
		      <li><a href="shopMain.shop?part=3/drama&pag=${pag}&pageSize=${pageSize}">DRAMA OST</a></li>
		      <li><a href="shopMain.shop?part=3/musical&pag=${pag}&pageSize=${pageSize}">MUSICAL OST</a></li>
		      <li><a href="shopMain.shop?part=3/ani&pag=${pag}&pageSize=${pageSize}">ANIMATION OST</a></li>
		    </ul>
		  </div>
		  
		  <div class="right">
		    <table class="table table-borderless text-center">
		    	<tr>
	    			<c:forEach var="vo" items="${vos}" varStatus="st">
			    		<td class="tbl1">
			    			<div>
			    				<a href="shopAlbumDetail.shop?idx=${vo.idx}&alName=${vo.alName}&singer=${vo.singer}">
			    					<img src="${vo.photo}" width="150px">
			    					<div style="width: 250px; margin: 0 auto">${vo.alName}</div>
			    				</a>
			    			</div>
			    			<div>
			    				<c:if test="${vo.stock > 0}">
				    				<c:set var="salePrice" value="${vo.price - (vo.price * vo.discount / 100)}" />
									<fmt:formatNumber value="${salePrice}" pattern="#,###"/> 
								</c:if>
								<c:if test="${vo.stock == 0}">
									<font color="red">품절</font>
								</c:if>
			    			</div>
	    					<c:if test="${sLevel == 0}">
			    				<div>
								  <i class="ri-box-3-fill"></i>(${vo.stock})
								  <a href="#" onclick="alDeleteCheck('${vo.idx}','${vo.alName}','${vo.singer}')" class="badge badge-danger" data-toggle="modal" data-target="#myModal">삭제</a>
								</div>
							</c:if>
			    		</td>
			    		<c:if test="${st.count % 3 == 0}"></tr><tr></c:if>
	    			</c:forEach>
		    	</tr>
		    </table>
		  </div>
		</div>
	</div>
	<!-- 블록페이지 시작(1블록의 크기를 3개(3Page)로 한다. 한페이지 기본은 5개 -->
<br/>
<div class="text-center">
  <ul class="pagination justify-content-center">
    <c:if test="${pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="shopMain.shop?part=${part}&pag=1&pageSize=${pageSize}">첫페이지</a></li></c:if>
  	<c:if test="${curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="shopMain.shop?part=${part}&pag=${(curBlock-1)*blockSize+1}&pageSize=${pageSize}">이전블록</a></li></c:if>
  	<c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize)+blockSize}" varStatus="st">
	    <c:if test="${i <= totPage && i == pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="shopMain.shop?part=${part}&pag=${i}&pageSize=${pageSize}">${i}</a></li></c:if>
	    <c:if test="${i <= totPage && i != pag}"><li class="page-item"><a class="page-link text-secondary" href="shopMain.shop?part=${part}&pag=${i}&pageSize=${pageSize}">${i}</a></li></c:if>
  	</c:forEach>
  	<c:if test="${curBlock < lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="shopMain.shop?part=${part}&pag=${(curBlock+1)*blockSize+1}&pageSize=${pageSize}">다음블록</a></li></c:if>
  	<c:if test="${pag < totPage}"><li class="page-item"><a class="page-link text-secondary" href="shopMain.shop?part=${part}&pag=${totPage}&pageSize=${pageSize}">마지막페이지</a></li></c:if>
  </ul>
</div>
<!-- 블록페이지 끝 -->	
	<!-- The Modal -->
<div class="modal fade" id="myModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content modal-sm">
      <!-- Modal Header -->
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><i class="ri-close-circle-fill"></i></button>
      </div>
      <!-- Modal body -->
      <div class="modal-body">
      	<div class="text-center"><b>해당 앨범을 <font color="red">삭제</font>합니다</b></div><hr class="m-2"/>
        <div class="text-center"><span class="mb-2" id="singer"></span></div>
        <div class="text-center"><span class="mb-2" id="alName"></span></div>
        <hr class="m-2"/>
        <form name="modalForm">
	        <b>관리자 비밀번호를 입력하세요.</b>
          <div><input type="password" name="pwd" id="pwd" value="1234" class="form-control"/></div>
          <hr class="m-2"/>
          <input type="button" value="삭제" onclick="albumDeleteOk()" class="btn btn-danger form-control" />
          <input type="hidden" name="idx" id="idx"/>
        </form>
      </div>
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-dark" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
	
	<script>
	
	
	
	function myFunction() {
	  var input, filter, ul, li, a, i;
	  input = document.getElementById("mySearch");
	  filter = input.value.toUpperCase();
	  ul = document.getElementById("myMenu");
	  li = ul.getElementsByTagName("li");
	  for (i = 0; i < li.length; i++) {
	    a = li[i].getElementsByTagName("a")[0];
	    if (a.innerHTML.toUpperCase().indexOf(filter) > -1) {
	      li[i].style.display = "";
	    } else {
	      li[i].style.display = "none";
	    }
	  }
	}
	</script>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>