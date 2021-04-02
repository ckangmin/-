<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
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
	<h2>Ajax 테스트</h2>
	
	<div>
		<div>
			REPLYER<input type="text" name="replyer" id="newReplyWriter">
		</div>
		<div>
			REPLY TEXT <input type="text" name="replytext" id="newReplyText">						
		</div>
	<button id="replyAddBtn">ADD REPLY</button>
	</div>
	<button id="listButton">Add List</button>
	<ul id="replies">
	</ul>
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

	<!--  jquery 이곳에  -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	
	
	<script type="text/javascript">

		var bno=2;
		
			// <ul> 내부에 집어넣을 <li> 요소를 그리기 위해 사용
		function getAllList(){
			$.getJSON("/replies/all/" +bno, function(da){
			var str= "";
				console.log(da.length);
				console.log(da);
		//자바의 forEach와 유사한 구문.
		//da내부의 요소들을 하나하나 순서대로 뽑아서
		//내부 코드를 실행합니다.  
		$(da).each(
				function(){
					// 특정요소 .html("문자열"); 을 실행하면
					//<> 문자열 </> 과 같이 태그사이에 넣을 문자열을
					// 지정할 수 있고, 그 문자열은 실제로 삽입될때는
					// html 요소로 간주되어 들어갑니다.
					// ul 태그 내에 li형태로 댓글정보를 넣기 위해
					// 아래와 같이 설정합니다.
					str += "<li data-rno='" +this.rno +"' class='replyLi'>"
						+this.rno + ":" + this.replytext
						+"<button>수정/삭제</button></li>";
				});
			$("#replies").html(str);
			});
		}//getAllList();
		$("#replyAddBtn").on("click", function() {
			var replyer = $("#newReplyWriter").val();
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
			    		getAllList(); 
			    	}
			    }
			});
		});//addBtn end
		$("#listButton").on("click", function(){
			getAllList();
		});
		//이벤트 위임
		//위임은 여러 요소를 독립정으로 기능시키면서도 하나의 이벤트로 처리할 때
		//사용하는 개념으로 아래와 같이 "button"이 클릭의 대상일때
		//버튼을 모두 포함하고 있는 가장 가까운 부모쪽 태그를 onclick의 타켓으로
		//잡고 대신 2번째 파라미터에 최종버튼과 그 사이의 요소를 기술함.
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
		});// replyModBtn end
		
		
		
	</script>
</body>
</html>