<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>shopMain.jsp</title>
<jsp:include page="/include/bs4.jsp" />
<style>
	body,ul,li {
		list-style: none;
	}
	a {
		text-decoration: inherit;
		color: white;
	}
	nav {
		text-align: left;
	}
	nav ul {
		background-color: black;
	}
	nav ul li {
		display: inline-block;
		position: relative;
		width: 110px;
		padding: 10px;
	}
	nav ul li:hover {
		background-color: gray;
	}
 	nav ul li ul {
    display: none;
    position: absolute;
    top: 40px;
    left: 0px;
  }
  nav ul li:hover ul {
    display: block;
  }
</style>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
	<div class="container">
		<div id="leftWindow">
			<nav>
				<ul>
					<li><a href="">주메뉴1</a>
						<ul>
							<li><a href="">서브메뉴1</a></li>
							<li><a href="">서브메뉴2</a></li>
							<li><a href="">서브메뉴3</a></li>
							<li><a href="">서브메뉴4</a></li>
						</ul>
					</li>
					<li><a href="">주메뉴2</a>
						<ul>
							<li><a href="">서브메뉴1</a></li>
							<li><a href="">서브메뉴2</a></li>
							<li><a href="">서브메뉴3</a></li>
							<li><a href="">서브메뉴4</a></li>
						</ul>
					</li>
					<li><a href="">주메뉴3</a>
						<ul>
							<li><a href="">서브메뉴1</a></li>
							<li><a href="">서브메뉴2</a></li>
							<li><a href="">서브메뉴3</a></li>
							<li><a href="">서브메뉴4</a></li>
						</ul>
					</li>
					<li><a href="">주메뉴4</a>
						<ul>
							<li><a href="">서브메뉴1</a></li>
							<li><a href="">서브메뉴2</a></li>
							<li><a href="">서브메뉴3</a></li>
							<li><a href="">서브메뉴4</a></li>
						</ul>
					</li>
				</ul>
			</nav>
		</div>
		<div id="rightWindow">
			<table>
				<tr>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</table>
		</div>
	</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>