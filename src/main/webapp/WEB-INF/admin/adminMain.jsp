<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>adminMain.jsp</title>
<jsp:include page="/include/bs4.jsp" />
<style>
 @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap');
	body {
		font-family: 'Noto Sans KR';
	}
	div.accodion {
		margin: 80px;
		float: left;
		width: 300px;
	}
	div.menu, div.content {
		padding: 20px;
		text-align: center;
		border-radius: 5px;
		background-color: #eee;
	}
	div.menu {
		background-color: black;
		color: white;
		padding: 5px;
	}
	#title {
		font-weight: bolder;
	}
	#title:hover, div.menu:hover {
		cursor: pointer;
		color: orange;
	}
	div .content > a:hover {
		text-decoration: none;
		color : orange;
	}
	footer {
		position: absolute;
		margin-top: 0px;
		padding: 0px;
		width: 100%;
	}
	#leftWindow {
		float: left;
		width: 25%;
		height: 1000px;
		text-align: center;
		background-color: #ddd;
	}
	#rightWindow {
		float: left;
		width: 75%;
		height: 1000px;
		text-align: left;
		background-color: #eee;
		overflow: auto;
	}

</style>
<script>
	'use strict';
	
	$(function() {
		$('#acc > .content').hide();
		$('#acc > .menu').click(function() {
			$(this).next().toggle(300);
		});
		
		$('#acc > #title').click(function() {
			$('#acc > .content').hide();
		});
	});
</script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
	<div>
		<div id="leftWindow">
			<div class="accodion" id="acc">
					<h3 id="title">관리자 메뉴</h3><br/>
					<div class="menu">상품관리</div>
					<div class="content">
							<a href="adminMain.ad?aSw=1">앨범 등록</a><br/>
					</div>
					<div class="menu">회원관리</div>
					<div class="content">
							<a href="adminMain.ad?aSw=2">회원리스트</a><br/>
					</div>
				</div>
		</div>
		<div id="rightWindow">
			<div>
				<c:if test="${aSw == 1}">
					<jsp:include page="adminAlbumInput.jsp" />
				</c:if>
			</div>
			<div>
				<c:if test="${aSw == 2}">
					<jsp:include page="adminMemberList.jsp" />
				</c:if>
			</div>
		</div>
	</div>
<div style="clear:both"></div>

<jsp:include page="/include/footer.jsp" />
</body>
</html>