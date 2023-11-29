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
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
	<div class="container">
	  <form name="myform" method="post" action="memberUpdateOk.mem" class="was-validated" enctype="multipart/form-data" >
	    <h2>회 원 정 보 수 정</h2>
	    <br/>
	    <div>아이디 : ${sMid}</div>
	    <div class="form-group">
	      <label for="nickName">닉네임 : &nbsp; &nbsp;<input type="button" id="nickNameBtn" value="닉네임 중복체크" class="btn btn-secondary btn-sm" onclick="nickCheck()"/></label>
	      <input type="text" value="${vo.nickName}" class="form-control" id="nickName" placeholder="별명을 입력하세요." name="nickName" required />
	    </div>
	    <div class="form-group">
	      <label for="name">성명 :</label>
	      <input type="text" value="${vo.name}" class="form-control" id="name" placeholder="성명을 입력하세요." name="name" required />
	    </div>
	    <div class="form-group">
	      <label for="email1">Email address:</label>
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
	      <div class="form-check-inline">
	        <span class="input-group-text">성별 :</span> &nbsp; &nbsp;
	        <label class="form-check-label">
	          <input type="radio" class="form-check-input" name="gender" value="남자" <c:if test="${vo.gender == '남자'}">checked</c:if>>남자
	        </label>
	      </div>
	      <div class="form-check-inline">
	        <label class="form-check-label">
	          <input type="radio" class="form-check-input" name="gender" value="여자" <c:if test="${vo.gender == '여자'}">checked</c:if>>여자
	        </label>
	      </div>
	    </div>
	    <div class="form-group">
	      <label for="birthday">생일</label>
	      <input type="date" name="birthday" value="${fn:substring(vo.birthday, 0,10)}" class="form-control"/>
	    </div>
	    <div class="form-group">
	      <div class="input-group mb-3">
	        <div class="input-group-prepend">
	          <span class="input-group-text">전화번호 :</span> &nbsp;&nbsp;
	            <select name="tel1" class="custom-select">
	              <option value="010" ${tel1 == '010' ? selected : ''}>010</option>
	              <option value="02" 	${tel1 == '02' ? selected : ''}>서울</option>
	              <option value="031" ${tel1 == '031' ? selected : ''}>경기</option>
	              <option value="032" ${tel1 == '032' ? selected : ''}>인천</option>
	              <option value="041" ${tel1 == '041' ? selected : ''}>충남</option>
	              <option value="042" ${tel1 == '042' ? selected : ''}>대전</option>
	              <option value="043" ${tel1 == '043' ? selected : ''}>충북</option>
	              <option value="051" ${tel1 == '051' ? selected : ''}>부산</option>
	              <option value="052" ${tel1 == '052' ? selected : ''}>울산</option>
	              <option value="061" ${tel1 == '061' ? selected : ''}>전북</option>
	              <option value="062" ${tel1 == '062' ? selected : ''}>광주</option>
	            </select>-
	        </div>
	        <input type="text" name="tel2" value="${tel2}" size=4 maxlength=4 class="form-control"/>-
	        <input type="text" name="tel3" value="${tel2}" size=4 maxlength=4 class="form-control"/>
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
	    <div  class="form-group">
	      회원 사진(파일용량:2MByte이내) :
	      <img src="${ctp}/images/member/${vo.photo}" width="100px" />
	      <input type="file" name="fName" id="file" onchange="imgCheck(this)" class="form-control-file border"/>
	      <div><img id="photoDemo" width="100px" /></div>
	    </div>
	    <button type="button" class="btn btn-secondary" onclick="fCheck()">정보수정</button> &nbsp;
	    <button type="reset" class="btn btn-secondary">다시작성</button> &nbsp;
	    <button type="button" class="btn btn-secondary" onclick="location.href='${ctp}/MemberLogin.mem';">돌아가기</button>
	    
	    <input type="hidden" name="email" />
	    <input type="hidden" name="tel" />
	    <input type="hidden" name="address" />
	    <input type="hidden" name="mid" value="${sMid}" />
	    <input type="hidden" name="photo" id="photo" value="${vo.photo}" />
	  </form>
	</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>