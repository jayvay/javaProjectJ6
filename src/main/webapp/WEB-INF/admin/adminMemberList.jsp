<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>adminMemberList.jsp</title>
<jsp:include page="/include/bs4.jsp" />
<style>
	 @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap');
	 body {
	 	font-family: 'Noto Sans KR';
	 }
	 
	 .xIcon {
	 	font-size: 15pt;
	 	color: red;
	 }
</style>
<script>
	'use strict';
	//등급 변경
	function levelChange(e) {
		let ans = confirm("선택한 회원의 등급을 변경하시겠습니까?");
		if(!ans) {
			location.reload();
			return false;
		}
		
		let items = e.value.split("/");
		console.log("items",items);
		let query = {
			idx : items[1], 
			level : items[0]
		};
		
		$.ajax({
			url : "adminMemberLevelChange.ad",
			type : "post",
			data : query,
			success : function(res) {
				if(res != "0") {
					alert("등급 수정 완료");
					location.reload();
				}
				else alert("등급 수정 실패");
			},
			error : function() {
				alert("전송 실패");
			}
		});
		
	}
	
	//등급 검색
	function lvSearch() {
		let level = document.getElementById("level").value;
		
		location.href = "adminMain.ad?aSw=2&level="+level;
	}
	
	//탈퇴신청한 회원 탈퇴시키기
	function memberDeleteOk(idx, photo) {
		let ans = confirm("선택한 회원을 정말 삭제하시겠습니까?");
		if(!ans) return false;
		
		$.ajax({
			url : "adminMemberDeleteOk.ad",
			type : "post",
			data : { idx : idx },
			success : function() {
				alert("회원 삭제 완료");
				location.reload();
			},
			error : function() {
				alert("전송 오류");
			}
		});
	}
</script>
</head>
<body>
<p><br/></p>
	<div class="container">
		<h2 class="text-center">${strLv} 회원 리스트</h2>
		<table class="table">
			<tr>
				<td>
					<div>등급별 검색
						<select name="level" id="level" onchange="lvSearch()">
							<option value="4" ${level==4 ? "selected" : ""}>전체회원</option>
							<option value="0" ${level==0 ? "selected" : ""}>관리자</option>
							<option value="1" ${level==1 ? "selected" : ""}>일반회원</option>
							<option value="2" ${level==2 ? "selected" : ""}>VIP</option>
							<option value="3" ${level==3 ? "selected" : ""}>VVIP</option>
							<option value="99" ${level==99 ? "selected" : ""}>탈퇴신청중</option>
						</select>
					</div>
				</td>
			</tr>
		</table>
		<table class="table table-hover">
			<tr class="table-dark text-dark">
				<th>번호</th>
				<th>아이디</th>
				<th>닉네임</th>
				<th>성명</th>
				<th>활동여부</th>
				<th>회원등급</th>
			</tr>
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<tr>
					<td>${curScrStartNo}</td>
					<td><a href="javascript:alert('준비중입니다.');">${vo.mid}</a></td>
					<%-- <td><a href="adminMemberInfor.ad?idx=${vo.idx}>${vo.mid}</a></td> --%>
					<td>${vo.nickName}</td>
					<td>${vo.name}</td>
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
  <!-- 블록페이지 끝 -->		
<p><br/></p>
</body>
</html>