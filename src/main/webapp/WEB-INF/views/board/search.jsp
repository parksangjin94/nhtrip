<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SEARCH</title>
<style type="text/css">
*{margin: 0;}
body{ 
	background:black !important;
}
.wrap {
	width: 100%;
}	
.letter {
	width: 980px;
	margin: 0 auto;
	color: white;
	padding: 1%;
	padding-top: 500px;
	text-align: center;
}
.grid-container {
	display: grid;
	grid-template-columns: 300px 300px 300px; /* 행 간격 */
	grid-column-gap: 40px;
	grid-row-gap: 40px;
	margin-top: 15%;
}
.view{
	width: 980px;
	margin: 0 auto;
	padding: 1%;
}
</style>
</head>
<body>
	<div class="wrap">
		<jsp:include page="../default/header.jsp" />
		<c:if test="${filelist.size() == 0 || filelist == null}">
			<div class="letter">검색 결과가 없습니다.</div>
		</c:if>
		<div class="view">
			<div class="grid-container">
				<c:forEach var="dto" items="${filelist }">
					<a href="${contextPath}/board/mypage?writeNo=${dto.writeNo}"><img
						width="300" height="300"
						src="${contextPath}/board/download?fileName=${dto.fileName}">
					</a>
				</c:forEach>
			</div>
		</div>
	</div>

</body>
</html>