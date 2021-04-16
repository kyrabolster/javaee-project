<%-- 
    Document   : error
    Created on : 23-Mar-2021, 3:21:52 PM
    Author     : KyraB
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" isErrorPage="true"%>
<%@include file="WEB-INF/jspf/taglibraries.jspf" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error</title>
        <%@include file="/WEB-INF/jspf/header.jspf" %>
        <%@include file="/WEB-INF/jspf/navigation.jspf" %>
    </head>
    <body>
        <div class="container">
            <c:choose>
                <c:when test="${ entity != null}">
                    <h1 class="text-center display-4 grey mt-5 mb-5"> 
                        Sorry! We couldn't find the  ${ entity } you are looking for.
                    </h1>

                    <h5 class="text-center">
                        See our list of ${ entity }s <a href="/ATSProject/${ entity }s">here</a>.
                    </h5>
                </c:when>
                <c:otherwise>
                    <c:redirect url="/404" />
                </c:otherwise>
            </c:choose>

        </div>  
    </body>
</html>
