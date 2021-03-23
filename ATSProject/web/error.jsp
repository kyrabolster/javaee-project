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
        <div>
            <%= exception.toString()%> 
        </div>
        <div>
            <%= exception.getMessage()%>
        </div>
        <div>
            <%= request.getRequestURI()%>
        </div>

        <a href="index.jsp">Home</a>        
    </body>
</html>
