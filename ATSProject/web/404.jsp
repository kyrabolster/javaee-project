<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="WEB-INF/jspf/taglibraries.jspf" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="WEB-INF/jspf/header.jspf" %>
        <title>Invoicing Application</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/navigation.jspf" %>
        <main>       
            <h1 class="text-center display-3 grey">Error</h1>
            <h3 class="text-center display-5 grey">This page does not exist</h3>
            <h5 class="text-center display-5 grey">
                <a href="${pageContext.request.contextPath}/home">Go Home</a>
            </h5>
        </main>
    </body>
    <%@include file="WEB-INF/jspf/footer.jspf" %>
</html>
