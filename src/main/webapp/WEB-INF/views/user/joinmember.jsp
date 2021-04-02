<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
</head>
<body>

<form>
	<div class="form-group has feedback">
	<div class="container">
		<div class="row">
		<div class="col-md-5">
		<input type="text" id="uid"name="uid" class="form-control" placeholder="ID"/></div>
		<div class="col-md-3 offset-md-2"><button type="button" id="ckid">아이디 중복확인</button></div>
		</div>	<!-- row end -->
	</div><!-- container end -->
	
	<div class="form-group has-feedback">
		<input type="password" id="upw" name="upw" class="form-control" placeholder="PW"/>
		<span class="glyphicon glyphicn-lock form-control-feedback"></span>
	</div>
	<div class="form-group has feedback">
		<input type="text" name="uname" id="uname" class="form-control" placeholder="Name"/>
		<span class="glyphicon glyphicon-envelop form-control-feedback"></span>
		
	</div>
	<button type="button" id="join" disabled >가입하기</button>
	</div>
</form>
<script type="text/javascript">
	$("#join").on("click", function(){
		var uid= $("#uid").val();
		var upw= $("#upw").val();
		var uname= $("#uname").val();
		$.ajax({
			type : 'post',
			url : '/user/',
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "POST"
			},
		    dataType : 'text',
		    data : JSON.stringify({
		    	uid : uid,
		    	upw: upw,
		    	uname : uname
		    }),
		    success : function(result) {
		    	if(result == 'SUCCESS'){
		    		alert("등록 되었습니다.");
		    		window.location.href = "/user/login";
		    		 
		    	}
		    }
		});
	});
	var idck = 0;
	
	    //idck 버튼을 클릭했을 때 
	    $("#ckid").click(function() {
	        
	        //userid 를 param.
	        var uid =  $("#uid").val(); 
	        
	        $.ajax({
	            async: true,
	            type : 'POST',
	            data : uid,
	            url : "/user/checkId",
	            dataType : "json",
	            contentType: "application/json; charset=UTF-8",
	            success : function(data) {
	                if (data.cnt > 0) {	                    
	                    alert("아이디가 존재합니다. 다른 아이디를 입력해주세요.");
	                    	                	                    	                
	                } else {
	                    alert("사용가능한 아이디입니다.");
	                    $("#uid").attr('readonly',true);
	                    $("#join").removeAttr('disabled');
	                    
	                }
	            }
	           
	        });
	    });



</script>
</body>
<
</html>