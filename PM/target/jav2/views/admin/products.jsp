<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%-- Định nghĩa contentPage để Layout include vào --%>
<c:set var="contentPage" value="/views/admin/products_content.jsp" scope="request" />
<jsp:include page="/layout/admin_layout.jsp" />