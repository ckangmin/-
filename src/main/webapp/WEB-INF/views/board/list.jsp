<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form>
	<div class="container">
	<h4 class="text-primary">게시글 목록</h4>
	<div class="row">
		<div class="row">
			<div class="box-body">
				<select name="searchType">
				<option value="n"
				<c:out value="${cri.searchType == null ? 'selected' : '' }"/>>
				-
				</option>
				<option value="t"
				<c:out value="${cri.searchType eq 't' ? 'selected' : '' }"/>>
				제목
				<option value="c"
				<c:out value="${cri.searchType eq 'c' ? 'selected' : '' }"/>>
				내용
				<option value="w"
				<c:out value="${cri.searchType eq 'w' ? 'selected' : '' }"/>>
				작성자
				<option value="tc"
				<c:out value="${cri.searchType eq 'tc' ? 'selected' : '' }"/>>
				제목,내용
				<option value="cw"
				<c:out value="${cri.searchType eq 'w' ? 'selected' : '' }"/>>
				내용,작성자
				</select>
				<input type="text"
					name="keyword"
					id="keywordInput"
					value="${cri.keyword }">
				<button id="searchBtn">Search</button>
			
			
			</div>
		</div>	
	</div>
	<table class="table table-hover">
		<thead>
		<tr>
			<th>글번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>수정일</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach var="list" items="${list}">
			<tr>
				<td>${list.bno}</td>
				<td>
				<a href="/board/get?bno=${list.bno}&page=${page}&searchType=${searchType}&keyword=${keyword}">
				${list.title}</a></td>
				<td>${list.writer}</td>
				<td>${list.updateDate}</td>
				<td>${list.regDate}</td>
			</tr>
		</c:forEach>
	</tbody>
	</table>
	<a href="register">
	<input class="btn btn-primary" value="글쓰기" ></a>
	<a href="board/register">
	<ul class="pagination justify-content-center">
		<c:if test="${pageMaker.prev }">
			<li class="page-item">
				<a class="page-link"
					href="/board/list?page=${pageMaker.startPage -1}&searchType=${searchType}&keyword=${keyword}">
					&laquo;
				</a>
			</li>
		</c:if>
					
			<c:forEach begin="${pageMaker.startPage }"
						end="${pageMaker.endPage }"
						var="idx">
					<li class="page-item
					<c:out value="${pageMaker.cri.page == idx ? 'active' : ''}"/>">
					<a class="page-link"
						href="/board/list?page=${idx }&searchType=${searchType}&keyword=${keyword}">${idx }</a>
					</li>
						</c:forEach>
						 
			<c:if test="${pageMaker.next && pageMaker.endPage>0 }">
				<li class="page-item">
				<a class="page-link"
					href="/board/list?page=${pageMaker.endPage+1}&searchType=${searchType}&keyword=${keyword}">
					&raquo;
					</a>
					</li>
					</c:if>
					 </ul>
  </form>

	</div><!--  div container end -->
	<!--  한단에 Script태그를 이용해 ${bno}를 콘솔에
	출력하는 구문을 작성해 list페이지의 개발자 도구 console창에 출력해보세요. -->
	<script type="text/javascript">
	$(document).ready(function(){
	//삭제된 글 번호는 controller 에서 넘어 옵니다.
	//${bno}라는 명칭으로 넘어오므로 변수에 저장합니다.
	//문자열 형태로 받아오도록 처리
	//그렇지 않으면 콘솔창에서 받은 자료가 없을때 에러가 남
	var bno ="${bno}";
	
	//받아 온 bno 출력
	console.log(bno);
	//alert()구문을 이용해 글을 삭제할때마다 
	//n번 글이 삭제되었습니다. 라는 안내문구를 띄어주세요.
		//alert()구문을 이용해 글을 삭제할때마다
		//n번 글이 삭제되었습니다 라는 안내문구를 띄어주세요.
		// 조건문을 이용해 삭제일때만 실행하도록 로직을 수정합니다.
		if(bno !== "" ){
		alert(bno+ "번 글이 삭제 되엇습니다.");}
	
	$('searchBtn').on("click", function(event){
		self.location="list"
		+ "?page=1"
		+ "&searchType="
		+$("select option:selected").val()
		+"&keyword=" + $("#keywordInput").val();
		
	})
	
	
	});
	</script>
</body>
</html>