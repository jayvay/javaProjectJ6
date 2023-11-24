<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>memberLogin.jsp</title>
<jsp:include page="/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
	<div class="container text-center">
		 <form name="loginForm" method="post" action="memberLoginOk.mem" >
  	<table class="table table-borderless">
  	  <tr>
  	    <td colspan="2" class="text-center"><h2>로그인</h2></td>
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
  	      [<a href = "javascript:midSearch()">아이디찾기</a>] / [<a href = "javascript:pwdSearch()">비밀번호찾기</a>]
  	    </td>
  	  </tr>
  	</table>
  </form>
  <form name="searchForm">
	  <div id="searchMid">
	    <hr/>
	  	<table class="table table-borderless p-0 text-center">
	  	  <tr>
	  	    <td class="text-center">
	  	      <font size="4"><b>아이디 찾기</b></font>
	  	      (가입시 입력한 메일주소를 입력하세요)
	  	    </td>
	  	  </tr>
	  	  <tr>
	  	    <td>
	  	      <div class="input-group">
	  	        <input type="text" name="emailSearch" id="emailSearch" class="form-control" placeholder="이메일 입력"/>
	  	        <div class="input-group-append">
	  	          <input type="button" value="이메일검색" onclick="emailFind()" class="btn btn-info" />
	  	        </div>
	  	      </div>
	  	    </td>
	  	  </tr>
	  	  <tr>
	  	    <td><div id="midShow"></div></td>
	  	  </tr>
	  	</table>
  	</div>
  	<div id="searchPassword">
	  	<hr/>
	  	<table class="table table-borderless p-0 text-center">
	  	  <tr>
	  	    <td class="text-center" colspan="2">
	  	      <font size="4"><b>비밀번호 찾기</b></font>
	  	      (가입시 입력한 메일주소를 입력하세요)
	  	    </td>
	  	  </tr>
	  	  <tr>
	  	  	<th>아이디</th>
	  	  	<td><input type="text" name="midSearch" id="midSearch" class="form-control" placeholder="아이디를 입력하세요"/></td>
	  	  </tr>
	  	  <tr>
	  	  	<th>이메일</th>
	  	  	<td><input type="text" name="emailSearch2" id="emailSearch2" class="form-control" placeholder="이메일을 입력하세요"/></td>
	  	  </tr>
	  	  <tr>
	  	    <td colspan="2">
	          <input type="button" value="새비밀번호발급" onclick="passwordFind()" class="btn btn-info" />
	  	    </td>
	  	  </tr>
  	  </table>
  	  <table class="table table-borderless">
	  	  <tr>
	  	    <td><div id="passwordShow"></div></td>
	  	  </tr>
	  	</table>
  	</div>
	</form>
	</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>