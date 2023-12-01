<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>shopReservation.jsp</title>
<jsp:include page="/include/bs4.jsp" />
	<style>
	  @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap');
		body {
			font-family: 'Noto Sans KR';
		}
 		#td1,#td8,#tdl5,#td22,#td29,#td36 {color: red}
 		#td7,#td14,#td21,#td28,#td35 {color: blue}
 		td:hover {
			cursor: pointer; 			
 		}
 		.bgColor {
      background-color: #669acc;
    }
 		.today {
 			background-color: black;
 			color: white;
 			font-weight: bolder;
 			text-align: left;
 		}
 		.btn-link {
 			color: black;
 		}
 		.btn-link:hover {
 			text-decoration: none;
 			color: gray;
 		}
 		tr a:hover {
 			text-decoration: none;
 			color: orange;
 		}
 		.col {
 			font-size: 14pt;
 			font-weight: bold;
 			text-align: center;
 			line-height: middle;
 		}
 	</style>
 	<script>
 		'use strict';
 		
 		 let sw = 0;
 		
 		$(function() {
	 		let year = '${year}';
	    let month = '${month+1}';
	    let day = '${day}';
	    let strToday = year + '-' + month + '-' + day; 
 		
			$('td').on('mousedown', function() {
			  if($(this).hasClass('bgColor') == true) {
          $(this).removeClass('bgColor');
        }
				else{
					let cellDay = Number($(this).text());

				  let todayDate = new Date(strToday);
					let cellDate = new Date(${yy} + '-' + ${mm+1} + '-' + cellDay); 
			    console.log('cellDate', cellDate);
				  
			    let diffDate = cellDate.getTime() - todayDate.getTime();
		      diffDate = diffDate / (60*60*24*1000);
		      if(diffDate < 0) {
		        alert("오늘 이전일은 선택할 수 없습니다.");
		        return false;
		      }	
		      else {  
		          if($('td').hasClass('bgColor') == true) {
		              $('td').removeClass('bgColor');
	            }
		          $(this).addClass('bgColor');
		          $("#rDate").val(${yy} + '-' + ${mm+1} + '-' + cellDay);
	       	}
				  
		      let firstDate = 0;
		      let lastDate = 0;  
		      if(sw == 0) {
			        firstDate = eval($(this).text());
			        if(firstDate > 30) {
			        	alert("현재화면에서는 이전달을 선택하실수 없습니다.");
			        	if($('td').hasClass('bgColor') == true) {
			              $('td').removeClass('bgColor');
			              $('#rDate').val(' ');
		            }
			        	return false;
			        }
			        $(this).addClass('bgColor');
			        sw = 1;
			      }
			      else {
			        lastDate = eval($(this).text());
			        if(firstDate > lastDate) {
			          alert("시작일 이후날짜를 선택해주세요");
			          return false;
			        }
			        else if(lastDate > 31){
    						alert("현재화면에서는 이전달/다음달을 선택하실수 없습니다.");
    						if($('td').hasClass('bgColor') == true) {
			              $('td').removeClass('bgColor');
			              $('#rDate').val(' ');
		            }
			          return false;
			        }
			      }
				}
			});
 		});
 		
 		function sendRDate() {
 			/* if(${yy}=="" && ${mm}=="" && ${dd}==""){
 				alert("날짜를 선택해주세요");
 			} */
      opener.document.getElementById("rDate").value  = document.getElementById("rDate").value;
      window.close();
    }
 	</script>
</head>
<body>
<p><br/></p>
	<div class="container">
	<form name="childForm">
		<div class="text-center">배송 받을 날짜를 예약할 수 있습니다. 날짜를 선택해주세요.</div>
		<div class="text-center">
			<button type="button" onclick="location.href='shopReserv.shop?yy=${yy-1}&mm=${mm}';" class="btn btn-link btn-sm" title="이전년도"><font size="5pt"><i class="ri-arrow-left-circle-fill"></i></font></button>
			<button type="button" onclick="location.href='shopReserv.shop?yy=${yy}&mm=${mm-1}';" class="btn btn-link btn-sm" title="이전월"><font size="5pt"><i class="ri-arrow-left-circle-line"></i></font></button>
			<font size="5">&nbsp;${yy}년 ${mm+1}월&nbsp;</font>
			<button type="button" onclick="location.href='shopReserv.shop?yy=${yy}&mm=${mm+1}';" class="btn btn-link btn-sm" title="다음월도"><font size="5pt"><i class="ri-arrow-right-circle-line"></i></font></button>
			<button type="button" onclick="location.href='shopReserv.shop?yy=${yy+1}&mm=${mm}';" class="btn btn-link btn-sm" title="다음년도"><font size="5pt"><i class="ri-arrow-right-circle-fill"></i></font></button>
			<button type="button" onclick="location.href='shopReserv.shop';" class="btn btn-link btn-sm" title="오늘날짜"><font size="5pt"><i class="ri-calendar-check-fill"></i></font></button>
		</div><br/>
		<div class="text-center">
			<table class="table table-bordered" style="background-color:#eee; width:100%;">
				<tr class="table-dark text-dark">
					<th style="width:13%; vertical-align:middle; color:red">sun</th>
					<th style="width:13%; vertical-align:middle;">mon</th>
					<th style="width:13%; vertical-align:middle;">tue</th>
					<th style="width:13%; vertical-align:middle;">wed</th>
					<th style="width:13%; vertical-align:middle;">thu</th>
					<th style="width:13%; vertical-align:middle;">fri</th>
					<th style="width:13%; vertical-align:middle; color:blue">sat</th>
				</tr>
				<tr>
					<!-- 시작일 이전을 공백을 이전 월의 날짜로 채운다(오늘이 수요일이면 startWeek는 4 이므로 3칸) -->
					<c:forEach var="prevDay" begin="${prevLastDay - (startWeek - 2)}" end="${prevLastDay}" varStatus="st">
         		 <td style="font-size:0.8em;color:#ccc;text-align:left;">${prevYear}-${prevMonth+1}-${prevDay}</td>
       		</c:forEach>
					
					<!-- 해당 월의 1일을 startWeek 위치부터 출력(날짜는 1씩 증가, 7칸이 채워지면 행 끊어주기) -->
					<c:set var="cell" value="${startWeek}" />
					<c:forEach begin="1" end="${lastDay}" varStatus="st">
						<c:set var="todaySw" value="${year == yy && month == mm && day == st.count ? 1 : 0}" />
						<td id="td${cell}" ${todaySw == 1 ? 'class=today' : '' } class="text-left" style="height:70px;">
							<font size="4pt">${st.count}</font><br/>
						</td>
						<c:if test="${cell % 7 == 0}"></tr><tr></c:if>
						<c:set var="cell" value="${cell + 1}" />
					</c:forEach>
					
					<!-- 마지막일 이후를 다음 달의 시작 일자부터 채운다 -->
					<c:if test="${(cell - 1) % 7 != 0}">
						<c:forEach var="nextDay" begin="${nextStartWeek}" end="7" varStatus="st">
							<td style="font-size:0.6em;color:#ccc;text-align:left;">${nextYear}-${nextMonth+1}-${st.count}</td>
						</c:forEach>
					</c:if>
				</tr>
			</table>
		</div> 
		<div class="row">
			<div class="col"></div>
			<div class="col text-center"><input type="text" name="rDate" id="rDate" readonly class="form-control" style="width:150%"/></div>
		 	<div class="text-center col"><input type="button" value="배송예약" onclick="sendRDate()" class="btn btn-info" /></div><br/>
			<div class="col"></div>
		</div><br/>
		※ 선택하신 날짜 전후 2~3일 이내로 배송이 완료됩니다.
	</form>
	</div>
<p><br/></p>
</body>
</html>