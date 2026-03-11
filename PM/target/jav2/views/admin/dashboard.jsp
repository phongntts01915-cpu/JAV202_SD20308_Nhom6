<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%-- Set đường dẫn file nội dung để Layout tự động nhúng vào --%>
<c:set var="contentPage" value="/views/admin/dashboard_content.jsp" scope="request" />
<jsp:include page="/layout/admin_layout.jsp" />