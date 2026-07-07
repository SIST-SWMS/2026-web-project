<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:if test="${empty main_jsp}">
    <c:set var="main_jsp" value="home.jsp" />
</c:if>

<jsp:include page="header.jsp"></jsp:include>

<jsp:include page="${main_jsp}"></jsp:include>

<jsp:include page="footer.jsp"></jsp:include>
