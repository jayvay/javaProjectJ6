<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>memberPwdChange.jsp</title>
<jsp:include page="/include/bs4.jsp" />
	<style>
	  @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap');
		body {
			font-family: 'Noto Sans KR';
		}
 		h3 {
 			font-weight: bold;
 		}
 		th {
 			background-color: #eee;
 		}
 	</style>
 	<script>
 		'use strict';
 		
 		function pwdCheck() {
 			let regPwd = /(?=.*[0-9a-zA-Z]).{4,20}$/;
 			let pwd = document.getElementById("pwd").value;
 			let newPwd = document.getElementById("newPwd").value;
 			let newPwdCheck = document.getElementById("newPwdCheck").value;
 			
 			if(!regPwd.test(newPwd)) {
 		    	alert("비밀번호는 1개 이상의 문자와 특수문자 조합의 6~24자리로 입력해주세요.");
 		    	myForm.pwd.focus();
 		    	return false;
 		    }
 		    else if(newPwd != newPwdCheck) {
 		    	alert("변경할 비밀번호가 같지 않습니다.");
 		    	myForm.newPwd.focus();
 		    	return false;
 		    }
 		    else{
 		    	myForm.submit();
 		    }
 		}		
 	</script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
	<div class="container">
	<form name="myForm" method="post" action="memberPwdChangeOk.mem">
		<h3 class="text-center">비밀번호 변경</h3>
		<table class="table table-hover">
	  	  <tr class="text-dark">
	  	    <th>현재 비밀번호</th>
	  	    <td><input type="password" name="pwd" id="pwd" class="form-control" required /></td>
	  	  </tr>
	  	  <tr>
	  	    <th>변경할 비밀번호</th>
	  	    <td><input type="password" name="newPwd" id="newPwd" class="form-control" required /></td>
	  	  </tr>
	  	  <tr>
	  	    <th>변경할 비밀번호 확인</th>
	  	    <td><input type="password" name="newPwdCheck" id="newPwdCheck" class="form-control" required /></td>
	  	  </tr>
	  	  <tr>
	  	    <td colspan="2" class="text-center">
	  	      <input type="button" value="비밀번호변경" onclick="pwdCheck()" class="btn btn-secondary mr-2" />
	  	      <input type="reset" value="다시입력" class="btn btn-secondary mr-2" />
	  	      <input type="button" value="돌아가기" onclick="location.href='memberInfoUpdate.mem?mid=${sMid}';" class="btn btn-secondary mr-2" />
	  	    </td>
	  	  </tr>
	  	</table>
	</form>
	</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>