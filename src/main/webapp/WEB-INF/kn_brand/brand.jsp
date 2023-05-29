<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>brand</title>
	<jsp:include page="/include/bs4.jsp" />
	<script>
		function here() {
			Swal.fire('Any fool can use a computer');
		}
	</script>
</head>
<body>
<jsp:include page="/include/nav.jsp" />
	<img src="${ctp}/images/kn_brand.png"/>
	<footer>
		<jsp:include page="/include/footer.jsp" />
	</footer>
</body>
</html>