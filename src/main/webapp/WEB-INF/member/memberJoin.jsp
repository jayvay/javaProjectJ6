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
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="${ctp}/js/woo.js"></script>
	<script>
		'use strict'
		
		let res = "";
		let myname = "";
		
		function signupCheck() {
		    let mid = document.getElementById("mid").value;
		    let pwd = document.getElementById("pwd").value;
		    let pwdcheck = document.getElementById("pwdcheck").value;
		    myname = document.getElementById("myname").value;
		    let birth = document.getElementById("birthday").value;
		    let age = document.getElementById("age").value;
		    let tel = document.getElementById("tel").value;
		    let email = document.getElementById("email").value;
		    let gender = document.myform.gender.value;
		    let nation = document.myform.nation.value;
		    let agree = document.getElementById("agree");
		    
		    if(mid=="" || mid==" ") {alert("필수 입력 사항을 전부 입력하셔야 합니다.")}
		    else if(pwd=="" || pwd==" ") {alert("필수 입력 사항을 전부 입력하셔야 합니다.")}
		    else if(pwdcheck=="" || pwdcheck==" ") {alert("필수 입력 사항을 전부 입력하셔야 합니다.")}
		    else if(myname=="" || myname==" ") {alert("필수 입력 사항을 전부 입력하셔야 합니다.")}
		    else if(birth=="" || birth==" ") {alert("필수 입력 사항을 전부 입력하셔야 합니다.")}
		    else if(email=="" || email==" ") {alert("필수 입력 사항을 전부 입력하셔야 합니다.")}
		    else if(agree.checked==false) {alert("개인정보 수집 밎 이용 약관에 동의하셔야 합니다.")}
		    else {
		        res += "아이디 : " + mid + "\n";
		        res += "이름 : " + myname + "\n";
		        res += "생년월일 : " + birth + "\n";
		        res += "나이 : " + age + "\n";
		        res += "연락처 : " +  tel + "\n";
		        res += "이메일 : " + email + "\n";
		        res += "성별 : " + gender + "\n";
		        res += "국가 : " + nation + "\n";
		        
		        console.log(res);
		        document.getElementById("memberinfo").value = res;
		
		        document.getElementById("mid").readOnly = true; 
		        document.getElementById("pwd").readOnly = true; 
		        document.getElementById("pwdcheck").readOnly = true; 
		        document.getElementById("myname").readOnly = true; 
		        document.getElementById("birthday").readOnly = true;
		        document.getElementById("age").readOnly = true; 
		        document.getElementById("tel").readOnly = true; 
		        document.getElementById("press") = disabled; 
		        document.getElementById("email").readOnly = true; 
		    }
		    myname = document.getElementById("myname").value;
		    
		    myform.submit();
		}
	</script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
	<div class="container" style="width:700px">
		<h4 style="text-align: center; padding:25px;">회 원 가 입</h4>
      <form name="myform" method="post" action="memberJoinOk.mem" class="was-validated">
        <div class="form-group">
            <label for="mid">아이디</label>
            <div class="input-group mb-3">
                <input type="text" class="form-control" name= mid id="mid" placeholder="아이디를 입력하세요" autofocus required />
                <div class="input-group-append"><input type="button" value="중복확인" class="btn btn-outline-primary"></div>
                <div class="invalid-feedback">필수 정보입니다.</div>
            </div>
        </div>
        <div class="form-group">
            <label for="pwd">비밀번호</label>
            <input type="password" name="pwd" id="pwd" placeholder="비밀번호를 입력하세요" class="form-control mb-3" required />
            <div class="invalid-feedback">필수 정보입니다.</div>
        </div>
        <div class="form-group">
            <label for="pwdcheck">비밀번호 확인</label>
            <input type="password" name="pwdcheck" id="pwdcheck" placeholder="비밀번호를 확인하세요" class="form-control mb-3" required />
            <div class="invalid-feedback">필수 정보입니다.</div>
        </div>
        <div class="form-group">
            <label for="myname">이름</label>
            <input type="text" name="myname" id="myname" placeholder="이름을 입력하세요" class="form-control mb-3" required />
            <div class="invalid-feedback">필수 정보입니다.</div>
        </div>   
        <div class="form-group">
            <label for="birthday">생년월일</label>
            <input type="text" name="birthday" id="birthday" placeholder="생년월일 8자리" class="form-control mb-3" required /> 
            <div class="invalid-feedback">필수 정보입니다.</div>
        </div>
        <div class="form-group">     
            <label for="age">나이</label>
            <input type="number" name="age" id="age" value="8" min="8" max="99" maxlength="2" class="form-control mb-3" />
            <div class="valid-feedback">8세 이상만 가입 가능합니다.</div>
        </div>
        <div class="form-group">
            <label for="tel">연락처</label><br/>
            <input style="width: 100%;" type="tel" name="tel" id="tel" class="col form-control mr-3" placeholder="-없이 숫자만 입력" />
        </div>
        <div class="form-group">
            <label for="email">이메일</label>
            <input type="email" name="email" id="email" class="form-control" placeholder="_____@_____.com" required />
            <div class="invalid-feedback">필수 정보입니다.</div>
        </div>
        <div class="form-group">
            <label for="gender">성별</label>
            <div class="row">
                <div class="col form-group btn-group btn-group-toggle" data-toggle="buttons">
                    <label class="btn btn-outline-primary">
                        <input type="radio" name="gender" id="genderm" value="남자" /> 남자
                    </label>
                    <label class="btn btn-outline-primary">
                        <input type="radio" name="gender" id="genderf" value="여자" /> 여자
                    </label>
                    <label class="btn btn-outline-primary">
                        <input type="radio" name="gender" id="gendern" value="선택안함" checked /> 선택안함
                    </label>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label for="nation">국가</label>
            <div class="row">
                <div class="col form-group btn-group btn-group-toggle" data-toggle="buttons">
                    <label class="btn btn-outline-primary">
                        <input type="radio" name="nation" id="nationk" value="내국인" checked /> 내국인
                    </label>
                    <label class="btn btn-outline-primary">
                        <input type="radio" name="nation" id="nationf" value="외국인" /> 외국인
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
    </form>
	</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>