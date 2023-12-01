<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>memberJoin.jsp</title>
	<jsp:include page="/include/bs4.jsp" />
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="${ctp}/js/woo.js"></script>
	<script>
		'use strict'
		
		let idCheckSw = 0;
		let nickCheckSw = 0;
		
		function idCheck() {
			let mid = myForm.mid.value;
			let url = "memberIdCheck.mem?mid="+mid;
	    	
	    	if(mid.trim() == "") {
	    		alert("아이디를 입력해주세요.");
	    		myForm.mid.focus();
	    	}
	    	else {
	    		idCheckSw = 1;
	    		myForm.mid.readOnly = true;
	    		window.open(url,"nWin","width=580px,height=250px");
	    	}
		}
		
		function nickCheck() {
    	let nickName = myForm.nickName.value;
    	let url = "${ctp}/memberNickCheck.mem?nickName="+nickName;
    	
    	if(nickName.trim() == "") {
    		alert("닉네임을 입력해주세요.");
    		myForm.nickName.focus();
    	}
    	else {
    		nickCheckSw = 1;
    		myForm.nickName.readOnly = true;
    		window.open(url,"nWin","width=580px,height=250px");
    	}
    }
		
		function signupCheck() {
		
			let regMid = /^[a-zA-Z0-9_]{4,10}$/;
    	let regPwd = /(?=.*[0-9a-zA-Z]).{4,20}$/;
      let regNickName = /^[가-힣a-zA-Z]+$/;
      let regName = /^[가-힣a-zA-Z]+$/;
      let regEmail =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
    	let regTel = /\d{3}-\d{3,4}-\d{4}$/g;
		
	    let mid = document.getElementById("mid").value.trim();
	    let pwd = document.getElementById("pwd").value;
	    let pwdcheck = document.getElementById("pwdcheck").value;
	    let name = document.getElementById("name").value;
	    let nickName = document.getElementById("nickName").value;
	    let birthday = document.getElementById("birthday").value;
	    let tel1 = myForm.tel1.value;
    	let tel2 = myForm.tel2.value.trim();
    	let tel3 = myForm.tel3.value.trim();
    	let tel = tel1 + "-" + tel2 + "-" + tel3;
    	let email1 = myForm.email1.value.trim();
    	let email2 = myForm.email2.value;
    	let email = email1 + "@" + email2;
	    let gender = document.myForm.gender.value;
	    let agree = document.getElementById("agree");
	    
	    let submitFlag = 0;

	    if(!regMid.test(mid))	{
	    	alert("아이디는 4~10자리의 영문 대/소문자와 숫자, 특수문자 '_'만 입력해주세요.");
	    	myForm.mid.focus();
	    	return false;
	    }
	    else if(!regPwd.test(pwd)) {
	    	alert("비밀번호는 1개 이상의 문자와 특수문자 조합의 6~24자리로 입력해주세요.");
	    	myForm.pwd.focus();
	    	return false;
	    }
	    else if(pwd != pwdcheck) {
	    	alert("입력하신 비밀번호가 같지 않습니다.");
	    	myForm.pwd.focus();
	    	return false;
	    }
	    else if(!regName.test(name)) {
	    	alert("성명은 한글과 영문 대/소문자로 입력해주세요.");
	    	myForm.name.focus();
	    	return false;
	    }
	    else if(!regNickName.test(nickName)) {
        alert("닉네임은 한글만 사용가능합니다.");
        myForm.nickName.focus();
        return false;
      }
	    else if(!regEmail.test(email)) {
	    	alert("이메일 형식에 맞지 않습니다.");
	    	myForm.email1.focus();
        return false;
	    }
	    else if(tel2 != "" && tel3 != "" && !regTel.test(tel)) {
    		alert("전화번호는 010-XXXX-XXXX 형식에 맞게 숫자로 입력해주세요.");
    		myForm.tel2.focus();
    		return false;
	    }
	    else if(agree.checked == false) {
	    	alert("개인정보 수집 밎 이용 약관에 동의하셔야 합니다.")
	    	return false;
	    }
	    else {
	    	submitFlag = 1;
	    }
	    
	    let postcode = myForm.postcode.value;
    	let roadAddress = myForm.roadAddress.value;
    	let detailAddress = myForm.detailAddress.value;
    	let extraAddress = myForm.extraAddress.value;
    	myForm.address.value = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress + "/";
	    
  		if(submitFlag == 1) {
    		if(idCheckSw == 0) {
    			alert("아이디 중복확인을 하지 않았습니다.");
    			document.getElementById("midBtn").focus();
    		}
    		else if(nickCheckSw == 0) {
    			alert("닉네임 중복확인을 하지 않았습니다.");
    			document.getElementById("nickNameBtn").focus();
    		}
    		else {
	    		myForm.email.value = email;
	    		myForm.tel.value = tel;
	    		
		    	myForm.submit();
    		}
    	}
    	else {
    		alert("회원가입 실패! 다시 시도하세요.");
    	}
		}
	</script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
	<div class="container" style="width:700px">
		<h3 style="font-weight:bolder; text-align:center; padding:25px;">회 원 가 입</h3>
      <form name="myForm" method="post" action="memberJoinOk.mem" class="was-validated">
        <div class="form-group">
            <label for="mid">아이디</label>
            <div class="input-group">
                <input type="text" class="form-control" name= mid id="mid" placeholder="아이디를 입력하세요" autofocus required/>
                <div class="input-group-append"><input type="button" id="midBtn" value="중복확인" onclick="idCheck()" class="btn btn-dark"></div>
            </div>
	          <div class="invalid-feedback">필수 정보입니다.</div>
        </div>
        <div class="form-group">
            <label for="pwd">비밀번호</label>
            <input type="password" name="pwd" id="pwd" placeholder="비밀번호를 입력하세요" class="form-control" required />
            <div class="invalid-feedback">필수 정보입니다.</div>
        </div>
        <div class="form-group">
            <label for="pwdcheck">비밀번호 확인</label>
            <input type="password" name="pwdcheck" id="pwdcheck" placeholder="비밀번호를 확인하세요" class="form-control" required />
            <div class="invalid-feedback">필수 정보입니다.</div>
        </div>
        <div class="form-group">
            <label for="name">이름</label>
            <input type="text" name="name" id="name" placeholder="이름을 입력하세요" class="form-control" required />
            <div class="invalid-feedback">필수 정보입니다.</div>
        </div>   
        <div class="form-group">
            <label for="nickName">닉네임</label>
            <div class="input-group">
            	<input type="text" name="nickName" id="nickName" placeholder="닉네임을 입력하세요" class="form-control" required />
            	<div class="input-group-append"><input type="button" id="nickNameBtn" value="중복확인" class="btn btn-dark" onclick="nickCheck()"/></div>
            </div>
            <div class="invalid-feedback">필수 정보입니다.</div>
        </div>   
        <div class="form-group">
            <label for="birthday">생년월일</label>
            <input type="date" name="birthday" id="birthday" class="form-control" required /> 
            <div class="invalid-feedback">필수 정보입니다.</div>
        </div>
        <div class="form-group">
            <label for="tel">연락처</label><br/>
        		<div class="input-group mb-3">
			        <input type="text" name="tel1" value="010" readonly class="form-control"/>&nbsp;&nbsp;-&nbsp;&nbsp;
			        <input type="text" name="tel2" size=4 maxlength=4 placeholder="3 또는 4자리 숫자" class="form-control" required/>&nbsp;&nbsp;-&nbsp;&nbsp;
			        <input type="text" name="tel3" size=4 maxlength=4 placeholder="3 또는 4자리 숫자" class="form-control" required/>
            <div class="invalid-feedback">필수 정보입니다.</div>
			   	  </div>
        </div>
        <div class="form-group">
            <label for="email">이메일</label>
            <div class="input-group mb-3">
		          <input type="text" class="form-control" placeholder="Email을 입력하세요." id="email1" name="email1" required />
		          <div class="input-group-append">
		            <select name="email2" class="custom-select">
		              <option value="naver.com" selected>naver.com</option>
		              <option value="hanmail.net">hanmail.net</option>
		              <option value="hotmail.com">hotmail.com</option>
		              <option value="gmail.com">gmail.com</option>
		              <option value="nate.com">nate.com</option>
		              <option value="yahoo.com">yahoo.com</option>
		            </select>
	          </div>
            <div class="invalid-feedback">필수 정보입니다.</div>
        </div>
        <div class="form-group">
		      <label for="address">주소</label>
		      <div class="input-group mb-1">
		        <input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control" required/>
		        <div class="input-group-append">
		          <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-dark">
		        </div>
		      </div>
		      <input type="text" name="roadAddress" id="sample6_address" size="50" placeholder="주소" class="form-control mb-1" required>
		      <div class="input-group mb-1">
		        <input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control" required> &nbsp;&nbsp;
		        <div class="input-group-append">
		          <input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control">
		        </div>
		      </div>
		    </div>
        <div class="form-group">
            <label for="gender">성별</label>
            <div class="row">
                <div class="col form-group btn-group btn-group-toggle" data-toggle="buttons">
                    <label class="btn btn-outline-dark">
                        <input type="radio" name="gender" id="genderm" value="남자" /> 남자
                    </label>
                    <label class="btn btn-outline-dark">
                        <input type="radio" name="gender" id="genderf" value="여자" /> 여자
                    </label>
                    <label class="btn btn-outline-dark">
                        <input type="radio" name="gender" id="gendern" value="선택안함" checked /> 선택안함
                    </label>
                </div>
            </div>
        </div>
        <div class="form-group form-check">
            <label class="form-check-label">
                <input type="checkbox" name="agree" id="agree" class="form-check-input" required> 개인정보 수집 및 이용 동의
                <div class="valid-feedback">이용 약관에 동의합니다.</div>
                <div class="invalid-feedback">이용 약관 동의(필수)</div>
            </label>
        </div>
        <button style="width: 100%;" type="button" class="btn btn-primary mt-3" onclick="signupCheck()" />가입할래요</button></div>
        <button style="width: 100%;" type="button" class="btn btn-secondary" onclick="location.href='memberLogin.mem';">취소</button>
 	  <input type="hidden" name="email" />
    <input type="hidden" name="tel" />
   	<input type="hidden" name="address" />
    </form>
	</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>