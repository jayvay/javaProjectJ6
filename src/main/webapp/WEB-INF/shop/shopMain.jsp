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
	body {
	  font-family: Arial, Helvetica, sans-serif;
	}
	
	* {
	  box-sizing: border-box;
	}
	
	/* Create a column layout with Flexbox */
	.row {
	  display: flex;
	}
	
	/* Left column (menu) */
	.left {
	  flex: 5%;
	  padding: 15px 0;
	}
	
	.left h2 {
	  padding-left: 8px;
	}
	
	/* Right column (page content) */
	.right {
	  flex: 65%;
	  padding: 15px;
	}
	
	/* Style the navigation menu inside the left column */
	#myMenu {
	  list-style-type: none;
	  padding: 0;
	  margin: 0;
	}
	
	#myMenu li a {
	  padding: 12px;
	  text-decoration: none;
	  color: black;
	  display: block
	}
	
	#myMenu li a:hover {
	  background-color: #eee;
	}
	img {
		margin:12px;
	}
	img:hover {
	  background-color: gray;
	  opacity : 0.7;
	}
	a:hover {
	  color : green;
  }
</style>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
	<div style="margin:0 100px">
		<div class="row">
		  <div class="left" style="background-color:#bbb;">
		    <h2>Menu</h2>
		    <ul id="myMenu" style="text-align:center">
		      <li><a href="#">HTML</a></li>
		      <li><a href="#">CSS</a></li>
		      <li><a href="#">JavaScript</a></li>
		      <li><a href="#">PHP</a></li>
		      <li><a href="#">Python</a></li>
		      <li><a href="#">jQuery</a></li>
		      <li><a href="#">SQL</a></li>
		      <li><a href="#">Bootstrap</a></li>
		      <li><a href="#">Node.js</a></li>
		    </ul>
		  </div>
		  
		  <div class="right">
		    <table class="table table-border text-center">
		    	<tr>
		    		<c:forEach var="vo" items="${vos}" varStatus="st">
			    		<td>
			    			<div>
			    				<a href="shopAlbumDetail.shop?idx=${vo.idx}&alName=${vo.alName}&singer=${vo.singer}">
			    					<img src="${vo.photo}" width="150px">
			    					<br/>${vo.alName}
			    				</a>
			    			</div>
			    			<div>${vo.price}</div>
			    		</td>
		    		</c:forEach>
		    	</tr>
		    </table>
		  </div>
		</div>
	</div>
	
	<script>
	function myFunction() {
	  var input, filter, ul, li, a, i;
	  input = document.getElementById("mySearch");
	  filter = input.value.toUpperCase();
	  ul = document.getElementById("myMenu");
	  li = ul.getElementsByTagName("li");
	  for (i = 0; i < li.length; i++) {
	    a = li[i].getElementsByTagName("a")[0];
	    if (a.innerHTML.toUpperCase().indexOf(filter) > -1) {
	      li[i].style.display = "";
	    } else {
	      li[i].style.display = "none";
	    }
	  }
	}
	</script>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>