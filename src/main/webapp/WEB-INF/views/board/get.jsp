<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	#modDiv{
	width: 300px;
	height: 100px;
	background-color: green;
	position: absolute;
	top: 50%;
	left: 50%;
	margin-top: -50px;
	margin-left: -150px;
	padding: 10px;
	z-index: 1000;
	
	}
</style>
</head>
<body>
	<div class="container">
		<div class="row">
			<h1 class="text-primary">${board.bno }번 글 내용</h1>
			<form class="form-group">
				<input type="hidden" 
					   name="bno" 
					   value="${board.bno }">
				<input type="hidden" name="searchType" value=${cri.searchType } />
				<input type="hidden" name="keyword" value=${cri.keyword } />					   
				<input type="hidden" name="page" value="${cri.page }">
				<div class="col-md-5">
				글쓴이<input type="text" class="form-control"
					readonly=true value="${board.writer }"><br>
				</div>
				<div class="col-md-5">
				글 제목<input type="text" class="form-control"  
					readonly=true value="${board.title }"><br>
				</div>
				본문<br>
				<div class="col-md-5">
				<textarea readonly=true class="form-control">
							${board.content }</textarea><br>
				</div>
				<div class="col-md-5">			
				등록날짜<input type="text" class="form-control" 
					readonly=true value=${board.regDate }><br>
				</div>
				<div class="col-md-5">
				수정날짜<input type="text" class="form-control"
					readonly=true value=${board.updateDate }>
				</div>
					<!-- button태그는 말 그대로 버튼을 만들어주는 태그
					 기본적으로는 input태그의 type=submit, reset등을
					 쓰듯이 사용하면 됨
					 가변적으로 action(목표url)속성을 바꿔주기 위해서
					 data-oper 속성을 이용해 어떤 버튼을 눌렀는지 함께
					 정보가 제공되도록 합니다.-->
					 <c:if test="${login.uname == board.writer}">
					<button type="submit" 
							data-oper="modify"
							class="btn btn-warning board">수정</button>
					<button type="submit"
							data-oper="remove"
							class="btn btn-danger board">삭제</button>
					</c:if>
					<a href="/board/list?page=${cri.page }&searchType=${cri.searchType}&keyword=${cri.keyword}"
					   class="btn btn-primary">목록</a>
			</form>

		</div>
		
		<div class="row">
			<h3 class="text-primary">댓글</h3>
			<div id="replies">
				<!-- 댓글이 들어갈 위치  -->
			</div>
		</div>
		<c:if test="${not empty login }">
		<div class="row box-box-success" >
			<div class="box-header">
				<h2 class="text-primary">댓글 작성</h2>
			</div><!-- header -->
			<div class="box-body">
				<strong>Writer</strong>
				<input type="text" id="newReplyer" placeholder="Replyer" class="form-control" value="${login.uname }" readonly>
				<strong>ReplyText</strong>
				<input type="text" id="newReplyText" placeholder="ReplyText" class="form-control">
				<div class="box-footer">
				
			</div><!-- body -->
				<button type="button" class="btn btn-success" id="replyAddBtn">Add Reply</button>
			</c:if>
			<c:if test="${empty login}">
					<div><a href="/user/login;">Login Please</a></div>
					
			</div>
			</c:if>
			
		</div><!-- row -->
		<div id="modDiv" style="display:none;">
		<div class="modal-title"></div>
		<div>
			<input type="text" id="replytext">
		</div>
		<div>
			
			<button type="button" id="replyModBtn">Modify</button>
			<button type="button" id="replyDelBtn">Delete</button>
			
			<button type="button" id="replycloseBtn">Close</button>
		
		</div>
	</div>

	</div>
	
	
</body>
<!-- 통상적으로 Javascript 코드는 페이지 제일 마지막에 기술합니다.
이유는 맨 위에 작성할 경우, 자바스크립트 코드가 모두 파싱되어야
그 때부터 html코드가 그려지기 시작하기 때문에
사용자 입장에서 파싱이 늦어지면 사이트가 느리다고 느낄 수 있습니다. 
자바스크립트 코드는 <script></script> 태그 사이에 입력하게 되며
스크립트릿과 마찬가지로 html코드 사이에 html이 아닌 코드를 삽입하기
위해서 사용합니다.
-->
	<script type="text/javascript">
		// 페이지가 로딩되자마자 버튼 감지 사전준비를 위해
		// 아래와 같이 작성합니다.
		// $(document.ready()) 내부의 코드는
		// 페이지가 로딩되는 순간 바로 실행됩니다.
		$(document).ready(function() {
			
			// 제이쿼리가 잘 작동하는지 테스트해봅니다.
			//alert("제이쿼리 작동!");
			
			// form 태그를 불러옵니다. 
			var formObj = $("form");
			
			// 1. form태그의 내용이 제대로 불러왔는지 확인합니다.
			// 확인이 되었다면 주석처리합니다.
			//console.log(formObj);
			
			// 2. form태그의 action부분을 고쳐보겠습니다.
			// .attr은 해당 태그의 속성값을 설정하는것이고
			// .("속성명", "대입할 속성") 순으로 작성합니다.
			// 하기 코드는 form태그의 action(목적주소)를
			// www.cowhdgns.com 으로 변경합니다.
			//formObj.attr("action", "http://www.cowhdgns.com");
			//console.log(formObj);
			
			// 3. 버튼을 클릭했을때 data-oper 값 감지하기.
			// 페이지 로딩완료가 아닌 버튼 클릭시 감지해야 하므로
			// 버튼 클릭 이벤트부터 처리합니다.
			$('.board').on("click", function(e){
				// 버튼 클릭시 submit으로 설정되어 있어서
				// 의도와 상관없이 바로 submit을 진행시킴
				// 따라서 그걸 막기 위해 코드 추가
				e.preventDefault();
				
				// 감지 로직
				var operation = $(this).data("oper");
				//console.log(operation);
				
				// 문제
				// method 속성은 post로 변경해주시고
				// 감지된 버튼이 remove인 경우
				// remove 페이지로 가도록 조건문을 짜 주시고
				// 감지된 버튼이 modify인 경우
				// modify 페이지로 가도록 조건문을 짜 주세요.
				formObj.attr("method", "post");
				
				if(operation === "modify"){
					formObj.attr("action", "/board/modify");
				}else if(operation === "remove"){
					formObj.attr("action", "/board/remove");
				}
				
	
				// 조건문이 다 돌면 제출되도록 처리하는 코드
				formObj.submit(); 
			});
			var bno=${board.bno};
			
			function getAllList(){
				$.getJSON("/replies/all/" +bno, function(da){
					var loginBool="${login.uname}"
				var str= "";
					console.log(da.length);
					console.log(da);
		
			$(da).each(
					function(){
						var timestamp=this.updatadate;
						var date= new Date(timestamp);
						
						var formattedTime="게시일 : "+ date.getFullYear()
										+"/" +(date.getMonth()+1)
										+"/" + date.getDate();
				if(this.replyer=== loginBool){
						str += "<div class='replyLi' data-rno='" +this.rno+ "'><strong>@"
						+this.replyer +"</strong> - "+formattedTime+"<br>" 
						+"<div class='replytext'>"+this.replytext + "</div>"
						+ "<button type='button' class='btn btn-info'>수정/삭제</button>"
						+"</div>";
				}
				else{
					str += "<div class='replyLi' data-rno='" +this.rno+ "'><strong>@"
					+this.replyer +"</strong> - "+formattedTime+"<br>" 
					+"<div class='replytext'>"+this.replytext + "</div>"
					+"</div>";
					
				}
					});
				$("#replies").html(str);
				});
			}
			
			
			getAllList();
			
			$("#replyAddBtn").on("click", function() {
				var replyer = $("#newReplyer").val();
				var replytext = $("#newReplyText").val();
				
				$.ajax({
					type : 'post',
					url : '/replies',
					headers : {
						"Content-Type" : "application/json",
						"X-HTTP-Method-Override" : "POST"
					},
				    dataType : 'text',
				    data : JSON.stringify({
				    	bno : bno,
				    	replyer: replyer,
				    	replytext : replytext
				    }),
				    success : function(result) {
				    	if(result == 'SUCCESS'){
				    		alert("등록 되었습니다.");
				    		$("#newReplyer").val("");
							$("#newReplyText").val("");
				    		getAllList(); 
				    	}
				    }
				});
			});//addBtn end
			$("#replies").on("click", ".replyLi button" ,function (){
				//"클릭한 버튼"의 부모요소만 특정지어 가져옴
				
				var reply=$(this).parent();
				//.atrr()는 파마리터를 하나 받은 경우 해당 속성의 값을 가져옴.
				var rno=reply.attr("data-rno");
				//.text()는 해당 태그읜 <와> 사이의 모든 자료를 삭제하고
				// 남는 요소만 가져옴
				var replytext=reply.text();
				//댓글 내의 들어있던 rno와 본문이 잘 가져와지는지 확인
				$(" .modal-title").html(rno);
				$("#replytext").val(replytext);
				$("#modDiv").show("slow");
				
				
			});//replyLi button
			$("#replycloseBtn").on("click" ,function(){
				
				$("#modDiv").hide("slow");
				
			});//closeBtn
			$("#replyDelBtn").on("click" ,function(){
				var rno=$(".modal-title").html();
				
				
				$.ajax({
					type:'delete',
					url: '/replies/' +rno,
					header : {
						"Content-Type" : "application/json",
						"X-HTTP-Method-Override" : "DELETE"
					},
					dataType : 'text',
					success: function(result){
						console.log("result: " +result);
						if(result=='SUCCESS'){
							alert("삭제 되었습니다.");
							$("#modDiv").hide("slow");
							getAllList();
						}
					}
					
				});
			});// replyDelBtn end
			$("#replyModBtn").on("click" ,function(){
				var rno=$(".modal-title").html();
				var replytext= $("#replytext").val();
				
				$.ajax({
					type:'patch',
					url: '/replies/' +rno,
					header : {
						"Content-Type" : "application/json",
						"X-HTTP-Method-Override" : "PATCH"
					},
					contentType:"application/json",
					data: JSON.stringify({replytext:replytext}),
					dataType : 'text',
					success: function(result){
						console.log("result: " +result);
						if(result=='SUCCESS'){
							alert("수정 되었습니다.");
							$("#modDiv").hide("slow");
							
							getAllList();
						}
					}
					
				});
			});
		});//document
	
		
	</script>
</html>




