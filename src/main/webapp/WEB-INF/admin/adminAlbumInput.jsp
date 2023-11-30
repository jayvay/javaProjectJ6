<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>adminAlbumInput</title>
<jsp:include page="/include/bs4.jsp" />
<style>
	.disc {
		overflow: auto;
		width: 100%;
  	height: 230px;
	}
	
	#discDelAll {
		display : none;
	}
</style>
<script>
	'use strict';
	
	$(function() {
		$("#discDelAll").hide();
	});
	
	function fCheck() {
		let photo = document.getElementById("photo").value;
		let ext = photo.substring(fName1.lastIndexOf(".")+1).toLowerCase(); // 확장자
		let maxSize = 1024 * 1024 * 10; //10MB (1KByte=1024Byte=10^3Byte=2^10Byte / 1MByte=2^20Byte=10^6Byte / 1GByte=2^30Byte=10^9Byte / 1TByte=2^40Byte=10^12Byte)
		
		let part1 = document.getElementById("part1").value;
		let part2 = document.getElementById("part2").value;
		
		if(photo.trim() == "") {
			alert("업로드할 파일을 선택하세요.");
			return false;
		}
		else if(part1 == 0 || part2 == 0) {
			alert("음반의 카테고리를 선택하세요.");
		}
		
		let fileSize = document.getElementById("photo").files[0].size;	//파일이 있어야 사이즈 체크가 됨
		
		if(ext != 'jpg' && ext != 'gif' && ext != 'png') {
  			alert("사진은 jpg/gif/png 파일만 업로드 가능합니다.")
		}
		else if(fileSize > maxSize) {
			alert("업로드 가능한 사진의 최대 용량은 10MByte 입니다.");
		}
		else {
			myform.submit();
		}
	}
	
	//업로드한 사진 미리보기
	function imgCheck(e) {
		let img = document.getElementById("photo").value;
		
		if(e.files && e.files[0]) {
			let reader = new FileReader();
			reader.onload = function(e) {
				document.getElementById("demo").src = e.target.result;
			}
			reader.readAsDataURL(e.files[0]);
		}  			
		else {
			document.getElementById("demo").src = "";
		}
	}
	
	let cnt = 0;
	
	function discAppendOne() {
		cnt++;
		let discBox = '';
		discBox += '<div id="dBox'+ cnt +'" class="dBox">';
		discBox += '<input type="text" name="disc" id="disc'+ cnt +'" class="form-control mb-2 border" style="float:left; width:85%;" />';
		discBox += '<input type="button" value="삭제" onclick="deleteBox('+ cnt +')" class="btn btn-warning mb-2 ml-2"/>';
		discBox += '</div>';
		$("#discBox").append(discBox);
		$("#discDelAll").show();
		$("#discAll").attr("disabled", true);
	}
	
	function discAppendAll() {
		cnt++;
		let discBox = '';
		discBox += '<div id="dBox'+ cnt +'" class="dBox">';
		discBox += '<textarea rows="7" name="disc" id="disc'+ cnt +'" placeholder="수록곡을 입력하세요." class="form-control mb-2 border"></textarea>';
		discBox += '</div>';
		$("#discBox").append(discBox);
		$("#discDelAll").show();
		$("#discOne").attr("disabled", true);
		$("#discAll").attr("disabled", true);
	}
	
	function deleteBox(cnt) {
		$("#dBox" + cnt).remove();
		$("#discOne").attr("disabled", false);
		$("#discAll").attr("disabled", false);
		
		if(cnt == 999) {
			$(".dBox").remove();
		}
	}
	
	let parts = false;

	function update_selected() {
	  $("#part2").val(0);
	  $("#part2").find("option[value!=0]").detach();

	  $("#part2").append(parts.filter(".part" + $(this).val()));
	}

	$(function() {
		parts = $("#part2").find("option[value!=0]");
		parts.detach();

	  $("#part1").change(update_selected);
	  $("#part1").trigger("change");
	});
</script>
</head>
<body>
<p><br/></p>
	<div class="container">
		<form name="myform" method="post" action="adminAlbumInputOk.ad" enctype="multipart/form-data">
			<table class="table table-bordered" >
				<tr><td colspan="2"><h3 class="text-center" style="font-weight:bold">음반 등록</h3></td></tr>
				<tr>
					<td style="width:50%">
						<div class="form-group">
						<label for="photo">앨범커버</label>
							<div class="text-center"><img src="${ctp}/images/noImage.jpg" id="demo" width="300px" /></div><br/>
							<input type="file" name="photo" id="photo" onchange="imgCheck(this)" class="form-control-file border mb-2" />
						</div>
						<div class="form-group">
						<label for="relDate">수록곡</label>&nbsp;&nbsp;
							<input type="button" id="discOne" value="수록곡추가" onclick="discAppendOne()" class="btn btn-dark btn-sm mt-2 mb-2" />
							<input type="button" id="discAll" value="수록곡한번에추가" onclick="discAppendAll()" class="btn btn-dark btn-sm mt-2 mb-2" />
							<input type="button" id="discDelAll" value="모두삭제" onclick="deleteBox(999)" class="btn btn-warning btn-sm mt-2 mb-2"/>
							<div class="disc"><table class="table table-borderless"><tr><td><div id="discBox"></div></td></tr></table></div>
						</div>
					</td>
					<td style="width:100%">
						<div class="form-group">
						<label for="part" >분류</label>
							<div class="row">
								&nbsp;&nbsp;<select class="form-control col-3" id="part1" name="part">
									<option value="0" selected="selected">분류</option>
									<option value="1">가요</option>
									<option value="2">POP/월드뮤직</option>
									<option value="3">OST</option>
								</select>&nbsp;
								<select class="form-control col-3" id="part2" name="part">
									<option value="0">장르</option>
									<option value="kballad" class="part1">발라드</option>
									<option value="kdance" class="part1">댄스</option>
									<option value="ksoul" class="part1">R&B/소울</option>
									<option value="krock" class="part1">ROCK</option>
									<option value="kindi" class="part1">인디</option>
									<option value="khiphop" class="part1">랩/힙합</option>
									<option value="wpop" class="part2">POP</option>
									<option value="wsoul" class="part2">R&B/소울</option>
									<option value="wrock" class="part2">ROCK</option>
									<option value="wjpop" class="part2">JPOP</option>
									<option value="movie" class="part3">영화</option>
									<option value="drama" class="part3">드라마</option>
									<option value="musical" class="part3">뮤지컬</option>
									<option value="ani" class="part3">애니메이션/게임</option>
								</select>
							</div>
						</div>
						<div class="form-group">
						<label for="alName">앨범명</label>
							<input type="text" name="alName" id="alName" autofocus class="form-control" />
						</div>
						<div class="form-group">
						<label for="singer">가수</label>
							<input type="text" name="singer" id="singer" class="form-control" />
						</div>
						<div class="form-group">
						<label for="stock">재고수량</label>
							<input type="number" name="stock" id="stock" class="form-control" />
						</div>
						<div class="row">
							<div class="form-group col">
							<label for="price">정가</label>
								<input type="number" name="price" id="price" class="form-control" />
							</div>
							<div class="form-group col">
							<label for="discount">할인율</label>
								<input type="number" name="discount" id="discount" class="form-control" />
							</div>
						</div>
						<div class="form-group">
						<label for="relDate">발매일</label>
							<input type="date" name="relDate" id="relDate" class="form-control" />
						</div>
						<div class="form-group">
						<label for="content">음반소개</label>
							<textarea rows="6" name="content" id="content" placeholder="음반 소개를 작성하세요." class="form-control"></textarea>
						</div>
					<td>
				</tr>
				<tr>
					<td colspan="2"><div><input type="button" value="앨범등록" onclick="fCheck()" class="btn btn-dark form-control" /></div></td>
				</tr>
			</table>
		</form>
	</div>
<p><br/></p>
</body>
</html>