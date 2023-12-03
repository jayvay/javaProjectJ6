<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>memberInfoUpdate.jsp</title>
<jsp:include page="/include/bs4.jsp" />
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="${ctp}/js/woo.js"></script>
<script>
  'use strict';
  // 닉네임 중복버튼을 클릭했는지를 확인하기위한 변수(버튼 클릭후에는 내용 수정처리 못하도록 처리)
  let nickCheckSw = 0;
  
  function updateCheck() {
  	// 유효성 검사.....
  	// 닉네임,성명,이메일,홈페이지,전화번호,비밀번호 등등....
  	
    let regNickName = /^[가-힣a-zA-Z]+$/;
    let regName = /^[가-힣a-zA-Z]+$/;
    let regEmail =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
  	let regTel = /\d{3}-\d{3,4}-\d{4}$/g;
  	
  	let nickName = myForm.nickName.value;
  	let name = myForm.name.value;
  	let email1 = myForm.email1.value.trim();
  	let email2 = myForm.email2.value;
  	let email = email1 + "@" + email2;
  	let tel1 = myForm.tel1.value;
  	let tel2 = myForm.tel2.value.trim();
  	let tel3 = myForm.tel3.value.trim();
  	let tel = tel1 + "-" + tel2 + "-" + tel3;
  	
  	let submitFlag = 0;		// 모든 체크가 정상으로 종료되게되면 submitFlag는 1로 변경처리될수 있게 한다.
  	
  	
  	// 앞의 정규식으로 정의된 부분에 대한 유효성체크
  	if(!regNickName.test(nickName)) {
      alert("닉네임은 한글과 영문대소문자만 사용할 수 있습니다.");
      myForm.nickName.focus();
      return false;
    }
    else if(!regName.test(name)) {
      alert("성명은 한글과 영문대소문자만 사용할 수 있습니다.");
      myForm.name.focus();
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
    else {
    	submitFlag = 1;
    }
  	
  	let postcode = myForm.postcode.value + " ";
  	let roadAddress = myForm.roadAddress.value + " ";
  	let detailAddress = myForm.detailAddress.value + " ";
  	let extraAddress = myForm.extraAddress.value + " ";
  	myForm.address.value = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress + "/";
  	
  	if(submitFlag == 1) {
  		if(nickCheckSw == 0) {
  			alert("닉네임 중복체크버튼을 눌러주세요!");
  			document.getElementById("nickNameBtn").focus();
  		}
  		else {
  			myForm.email.value = email;
  			myForm.tel.value = tel;
    		
  			myForm.submit();
  		}
  	}
  	else {
  		alert("회원정보수정 실패");
  	}
  	
  }
  
  // 닉네임 중복체크
  function nickCheck() {
  	let nickName = $("#nickName").val();

  	if(nickName == '${sNickName}') {
  		alert("현재 닉네임을 그대로 사용합니다....");
  		nickCheckSw = 1;
  		$("#nickName" ).prop('readonly', true);
  		return false;
  	}
  	
  	let url = "${ctp}/memberNickCheck.mem?nickName="+nickName;
  	
  	if(nickName == "") {
  		alert("닉네임을 입력하세요!");
  		myForm.nickName.focus();
  	}
  	else {
  		nickCheckSw = 1;
  		//myform.nickName.readOnly = true;
  		$("#nickName" ).prop('readonly', true);
  		window.open(url,"nWin","width=580px,height=250px");
  	}
  }
  
</script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
	<div class="container" style="width:60%">
	  <form name="myForm" method="post" action="memberUpdateOk.mem" class="was-validated">
	    <h2>회 원 정 보 수 정</h2>
	    <br/>
	    <div class="form-group">
	      <label for="name">아이디</label>
	      <input type="text" value="${sMid}" class="form-control" id="mid" name="mid" readonly />
	    </div>
	    <div class="form-group">
    		<label for="nickName">닉네임 &nbsp; &nbsp;</label>
	    	<div class="input-group">
		      <input type="text" value="${vo.nickName}" class="form-control" id="nickName" name="nickName" placeholder="닉네임을 입력하세요." required />
		      <div class="input-group-append"><input type="button" id="nickNameBtn" value="닉네임 중복확인" class="btn btn-dark btn-sm" onclick="nickCheck()"/></div>
	    	</div>
	    </div>
	    <div class="form-group">
	      <label for="name">성명</label>
	      <input type="text" value="${vo.name}" class="form-control"  name="name" id="name" placeholder="성명을 입력하세요." required />
	    </div>
	    <div class="form-group">
	      <label for="email1">이메일</label>
	        <div class="input-group mb-3">
	        	<c:set var="email" value="${fn:split(vo.email , '@')}" />
	          <input type="text" value="${email[0]}" class="form-control" placeholder="Email을 입력하세요." id="email1" name="email1" required />
	          <div class="input-group-append">
	            <select name="email2" class="custom-select">
	              <option value="naver.com"   ${email[1] == 'naver.com' ? 'selected' : ''}>naver.com</option>
	              <option value="hanmail.net" ${email[1] == 'hanmail.net' ? 'selected' : ''}>hanmail.net</option>
	              <option value="hotmail.com" ${email[1] == 'hotmail.com' ? 'selected' : ''}>hotmail.com</option>
	              <option value="gmail.com" 	${email[1] == 'gmail.com' ? 'selected' : ''}>gmail.com</option>
	              <option value="nate.com" 		${email[1] == 'nate.com' ? 'selected' : ''}>nate.com</option>
	              <option value="yahoo.com" 	${email[1] == 'yahoo.com' ? 'selected' : ''}>yahoo.com</option>
	            </select>
	          </div>
	        </div>
	    </div>
	    <div class="form-group">
        <label for="gender">성별</label><br/>
	      <div class="form-check-inline">
	        <label class="form-check-label">
	          <input type="radio" class="form-check-input" name="gender" value="남자" <c:if test="${vo.gender == '남자'}">checked</c:if>>남자
	        </label>
	      </div>
	      <div class="form-check-inline">
	        <label class="form-check-label">
	          <input type="radio" class="form-check-input" name="gender" value="여자" <c:if test="${vo.gender == '여자'}">checked</c:if>>여자
	        </label>
	      </div>
	      <div class="form-check-inline">
	        <label class="form-check-label">
	          <input type="radio" class="form-check-input" name="gender" value="선택안함" <c:if test="${vo.gender == '선택안함'}">checked</c:if>>선택안함
	        </label>
	      </div>
	    </div>
	    
	    <div class="form-group">
	      <label for="birthday">생일</label>
	      <input type="date" name="birthday" value="${fn:substring(vo.birthday, 0,10)}" class="form-control"/>
	    </div>
	    <div class="form-group">
      	<label for="tel">전화번호</label><br/>
	      <div class="input-group mb-3">
          <input type="text" name="tel1" value="010" readonly class="form-control"/>-&nbsp;
	        <input type="text" name="tel2" value="${tel2}" size=4 maxlength=4 class="form-control"/>-&nbsp;
	        <input type="text" name="tel3" value="${tel3}" size=4 maxlength=4 class="form-control"/>
	      </div>
	    </div>
	    <div class="form-group">
	      <label for="address">주소</label>
	      <div class="input-group mb-1">
	        <input type="text" name="postcode" id="sample6_postcode" value="${postcode}" placeholder="우편번호" class="form-control">
	        <div class="input-group-append">
	          <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-secondary">
	        </div>
	      </div>
	      <input type="text" name="roadAddress" id="sample6_address" value="${roadAddress}" size="50" placeholder="주소" class="form-control mb-1">
	      <div class="input-group mb-1">
	        <input type="text" name="detailAddress" id="sample6_detailAddress" value="${detailAddress}" placeholder="상세주소" class="form-control"> &nbsp;&nbsp;
	        <div class="input-group-append">
	          <input type="text" name="extraAddress" id="sample6_extraAddress" value="${extraAddress}" placeholder="참고항목" class="form-control">
	        </div>
	      </div>
	    </div>
	    <button type="button" class="btn btn-dark mr-2" onclick="updateCheck()">정보수정</button>
	    <button type="button" class="btn btn-dark mr-2" onclick="location.href='memberPwdChange.mem';">비밀번호변경</button>
	    <button type="reset" class="btn btn-dark mr-2">다시작성</button>
	    <button type="button" class="btn btn-dark mr-2" onclick="location.href='memberMain.mem';">돌아가기</button>
	    
	    <input type="hidden" name="email" />
	    <input type="hidden" name="tel" />
	    <input type="hidden" name="address" />
	    <input type="hidden" name="mid" value="${sMid}" />
	  </form>
	</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>