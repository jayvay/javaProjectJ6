<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	int level = session.getAttribute("sLevel")==null ? 99 : (int)session.getAttribute("sLevel");
	pageContext.setAttribute("level", level);
%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<style>
	 @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap');
		body {
			font-family: 'Noto Sans KR';
		}
</style>
<script>
	'use strict';

	function memberDelCheck() {
		let ans = confirm("정말 탈퇴하시겠습니까?");
		if(ans) {
			let ans2 = confirm("탈퇴 후 1개월 간 같은 아이디로 다시 가입할 수 없습니다.\n그래도 탈퇴하시겠습니까?");
			if(!ans2) return false;
		}
		else return false;
		
		//회원탈퇴
		$.ajax({
			url : "memberDeleteCheck.mem",
			type : "post",
			success : function(res) {
				if(res != "1") alert("회원 탈퇴 실패");
				else location.href = "memberLogout.mem";
			},
			error : function() {
				alert("전송 오류");
			}
		});
	}
	
</script>
<nav class="navbar navbar-expand-sm navbar-dark" style="background-color:black">
	<!-- 햄버거 버튼 -->
  <a class="navbar-brand" href="http://49.142.157.251:9090/javaProjectJ6">Home</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="collapsibleNavbar">
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" href="shopMain.shop">SHOP</a>
      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="javascript:alert('해당 페이지는 준비중입니다.');">BOARD</a>
	      </li>
	      <c:if test="${level == 0}">
		      <li class="nav-item">
		        <a class="nav-link" href="adminMain.ad">ADMIN</a>
		      </li>    
	      </c:if>
	      <c:if test="${level < 4}">
		      <li class="nav-item ml-2 mr-2">
		         <div class="dropdown">
						    <button type="button" class="btn dropdown-toggle" data-toggle="dropdown" style="color:gray; background-color:black;">MyPage</button>
						    <div class="dropdown-menu">
						      <a class="dropdown-item" href="shopCartList.shop">장바구니</a>
						      <a class="dropdown-item" href="memberMain.mem">마이페이지</a>
						      <a class="dropdown-item" href="#" data-toggle="modal" data-target="#myModalPwdCheck" >회원정보수정</a>
						      <a class="dropdown-item" href="javascript:memberDelCheck()">회원탈퇴</a>
						      <c:if test="${sLevel == 0}"><a class="dropdown-item" href="adminMain.ad">관리자메뉴</a></c:if>
						    </div>
						  </div>
		      </li>
	      </c:if>
      <%-- </c:if> --%>
     	<li class="nav-item">
        <c:if test="${level > 4}"><a class="nav-link" href="memberLogin.mem">Login</a></c:if>
        <c:if test="${level < 4}"><a class="nav-link" href="memberLogout.mem">Logout</a></c:if>
      </li>
      <li class="nav-item">
        <c:if test="${level > 4}"><a class="nav-link" href="memberJoin.mem">Join</a></c:if>
      </li>            
    </ul>
  </div>  
</nav>	
 <!-- 비밀번호 찾기 -->
<div class="modal fade" id="myModalPwdCheck">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
    
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title"><b>회원정보 수정</b></h4><br/>
        <button type="button" class="close" data-dismiss="modal"><i class="ri-close-circle-fill"></i></button>
      </div>
      
      <!-- Modal body -->
      <div class="modal-body">
	      <form name="myform" method="post" action="memberPwdCheckOk.mem" >
	        <table class="table table-borderless">
	        	<div class="text-center">회원정보 수정을 위해 비밀번호를 확인합니다</div>
			  	  <tr>
			  	  	<td><input type="password" name="pwdCheck" id="pwdCheck" class="form-control" placeholder="비밀번호를 입력하세요"/></td>
			  	  </tr>
			  	  <tr>
			  	    <td class="text-center"><input type="submit" value="비밀번호확인" class="btn btn-dark mt-2" /></td>
			  	  </tr>
	        </table>
	       </form>
	        <div id="demo"></div>
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
      
     </div> 
	</div>
</div>