<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<%
	Cookie[] cookies = request.getCookies();

	if(cookies != null) {
		for(int i=0; i<cookies.length; i++) {
			if(cookies[i].getName().equals("cMid")) {
				pageContext.setAttribute("mid", cookies[i].getValue());
				break;
			}
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>memberLogin.jsp</title>
<jsp:include page="/include/bs4.jsp" />
<script>
	'use strict';
	
	function midFind() {
		let name = $("#nameSearch").val().trim();
		let email = $("#emailSearch1").val().trim();
		if(name == "") {
			alert("이름을 입력하세요.");
			$("#nameSearch").focus();
			return false;
		}
		else if(email == "") {
			alert("가입시 등록한 이메일을 입력하세요.");
			$("#emailSearch1").focus();
			return false;
		}
		
		let query = {
    			name : name,
    			email : email
  	}	
    	
		$.ajax({
    		url  : "memberMidSearch.mem",
    		type : "post",
    		data : query,
    		success:function(res) {
    			let str = '';
    			if(res == 0) {
    				str = '검색하신 회원 정보가 없습니다.';
    			}
    			else {
	    			let mids = res.split("/");
	    			str = '검색결과 : <br/><b>';
	    			for(let i=0; i<mids.length; i++) {
	    				let jump = Math.floor((Math.random()*(3-2)) + 2);
	    				let tempMid = mids[i].substring(0,2);
	    				for(let j=1; j<mids[i].length-1; j++) {
	    					tempMid += "*";
	    				}
		    			str += tempMid;
		    			
		    			str += "<br/>";
	    			}
	    			str += '</b>';
    			}
    			midShow.innerHTML = str;
    		},
    		error : function() {
    			alert("전송 오류!");
    		}
  	});
	}
    
  //비밀번호 검색처리
  function passwordFind() {
			let mid = $("#midSearch").val().trim();
    	let email = $("#emailSearch2").val().trim();
    	if(mid == "" || email == "") {
    		alert("가입한 아이디와 메일주소를 입력하세요");
    		$("#midSearch").focus();
    		return false;
    	}
    	
    	let query = {
    			mid : mid,
    			email : email
    	}
    	
    	$.ajax({
    		url : "memberPwdSearch.mem",
    		type : "post",
    		data : query,
    		success : function(res) {
					passwordShow.innerHTML = "결과 : " + res;
    		},
    		error : function() {
					alert("전송 오류");
				}
    	});
	}
  
	function modalView() {
		$("#myModal #emailSearch1").html(emailSearch1);
		$("#myModal #midSearch").html(midSearch);
		$("#myModal #emailSearch2").html(emailSearch2);
	}
	
	function searchClose() {
		nameSearch.value = null;
		emailSearch1.value = null; 
		midShow.innerHTML = "";
		midSearch.value = null; 
		emailSearch2.value = null; 
	}
</script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
	<div class="container text-center" style="width:700px">
		<form name="loginForm" method="post" action="memberLoginOk.mem" >
	  	<table class="table table-borderless">
	  	  <tr>
	  	    <td colspan="2" class="text-center"><h3 style="font-weight:bolder; margin-top:100px;">로 그 인</h3></td>
	  	  </tr>
	  	  <tr>
	  	    <!-- <th class="text-center col-1">아이디</th> -->
	  	    <td class="col-2 m-0 p-0 text-center">
	  	      <input type="text" name="mid" id="mid" value="${mid}" placeholder="아이디" class="form-control" style="margin-bottom:1px;" autofocus required />
	  	      <input type="password" name="pwd" id="pwd" value="1234" class="form-control" required />  	    
	  	    </td>
	  	  </tr>
	  	  <tr>
	  	    <td class="text-left col-1"><input type="checkbox" name="idSave" checked style="font-size:3pt"/> 아이디 저장</td>
	  	    <!-- <th class="text-center">비밀번호</th>
	  	    <td class="m-0"><input type="password" name="pwd" id="pwd" value="1234" class="form-control" required /></td> -->
	  	  </tr>
	  	  <tr>
	  	    <td colspan="2" class="text-center">
	  	      <input type="submit" value="로그인" class="btn btn-dark mr-2 form-control" />
	  	    </td>
	  	  </tr>
	  	  <tr>
	  	     <td colspan="2" class="text-center"><input type="button" value="회원가입" onclick="location.href='memberJoin.mem';" class="btn btn-dark form-control" /></td>
	  	  </tr>
	  	  <tr>
	  	    <td colspan="2" class="text-center">
	  	    	<font size="2">아이디 / 비밀번호를 잊으셨나요?</font>
  	        <button type="button" class="btn btn-sm btn-light" data-toggle="modal" data-target="#myModalMidSearch">아이디찾기</button>
  	        <button type="button" class="btn btn-sm btn-light" data-toggle="modal" data-target="#myModalPwdSearch">비밀번호찾기</button>
	  	    </td>
	  	  </tr>
	  	</table>
		</form>
	  
	   <!-- 아이디 찾기 -->
    <div class="modal fade" id="myModalMidSearch">
	    <div class="modal-dialog modal-dialog-centered">
	      <div class="modal-content">
	      
	        <!-- Modal Header -->
	        <div class="modal-header">
	          <h4 class="modal-title"><b>아이디 찾기</b></h4><br/>
	          <button type="button" class="close" data-dismiss="modal"><i class="ri-close-circle-fill"></i></button>
	        </div>
	        
	        <!-- Modal body -->
	        <div class="modal-body">
	        <form name="midSearchForm">
	          <table class="table table-borderless p-0 text-center">
				  	  <tr>
				  	  	<th>이름</th>
				  	  	<td><input type="text" name="nameSearch" id="nameSearch" class="form-control" placeholder="이름을 입력하세요"/></td>
			  	  	</tr>
			  	    <tr>
				  	  	<th>이메일</th>
			  	    	<td><input type="text" name="emailSearch1" id="emailSearch1" class="form-control" placeholder="가입시 입력한 이메일을 입력하세요"/></td>
	  	    		</tr>
		  	      <tr><td colspan="2"><input type="button" value="아이디검색" onclick="midFind()" class="btn btn-dark" /></td></tr>
				  	  <tr>
				  	    <td colspan="2"><div id="midShow"></div></td>
				  	  </tr>
		  			</table>
		  		</form>
	        </div>
	        <!-- Modal footer -->
	        <div class="modal-footer">
	          <button type="button" class="btn btn-secondary" onclick="searchClose()" data-dismiss="modal">닫기</button>
	        </div>
	        
	       </div> 
	  	</div>
    </div>
    
    <!-- 비밀번호 찾기 -->
    <div class="modal fade" id="myModalPwdSearch">
	    <div class="modal-dialog modal-dialog-centered">
	      <div class="modal-content">
	      
	        <!-- Modal Header -->
	        <div class="modal-header">
	          <h4 class="modal-title"><b>비밀번호 찾기</b></h4><br/>
	          <button type="button" class="close" data-dismiss="modal"><i class="ri-close-circle-fill"></i></button>
	        </div>
	        
	        <!-- Modal body -->
	        <div class="modal-body">
	          <table class="table table-borderless">
				  	  <tr>
				  	  	<th>아이디</th>
				  	  	<td><input type="text" name="midSearch" id="midSearch" class="form-control" placeholder="아이디를 입력하세요"/></td>
				  	  </tr>
				  	  <tr>
				  	  	<th>이메일</th>
				  	  	<td><input type="text" name="emailSearch2" id="emailSearch2" class="form-control" placeholder="가입시 입력한 이메일을 입력하세요"/></td>
				  	  </tr>
				  	  <tr>
				  	    <td colspan="2">
				  	    	<font size="2">임시비밀번호를 이메일로 전송해드립니다!</font><br/>
				          <input type="button" value="이메일전송" onclick="passwordFind()" class="btn btn-dark mt-2" />
				  	    </td>
				  	  </tr>
	          </table>
	        </div>
	        
	        <!-- Modal footer -->
	        <div class="modal-footer">
	          <button type="button" class="btn btn-secondary" onclick="searchClose()" data-dismiss="modal">닫기</button>
	        </div>
	        
	       </div> 
	  	</div>
    </div>
	  
	</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>