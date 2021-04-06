<%-- 
    Document   : tasksummary
    Created on : 17-Mar-2021, 3:19:37 PM
    Author     : Soyoung Kim
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="WEB-INF/jspf/taglibraries.jspf" %>
<c:set var="vm" value="${vm}" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="WEB-INF/jspf/header.jspf" %>
        <title>ATS - Task</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/navigation.jspf" %>
        <main>
            <div class="container">
                <h1 class="text-center display-4 grey mt-5 mb-5">Summary</h1>
                <h4>${ deleteMessage }</h4>
                <c:choose>
                    <c:when test="${ vm.rowsDeleted != null }">
                        <h4>Task deleted Id: <span class="font-weight-bold">${task.id}</span></h4>
                        </c:when>
                        <c:otherwise>
                        <table class="table table-striped">
                            <tbody>
                                <tr>
                                    <td style="text-align: right;">Task Id</td>
                                    <td>${ task.id }</td>
                                </tr>
                                <tr>
                                    <td style="text-align: right;">Task Name</td>
                                    <td>${ task.name }</td>
                                </tr>
                                <tr>
                                    <td style="text-align: right;">Task Description:</td>
                                    <td>${ task.description }</td>
                                </tr>
                                <tr>
                                    <td style="text-align: right;">Task Duration:</td>
                                    <td>${ task.duration}</td>
                                </tr>
                        </table>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>        
    </body>
    <%@include file="WEB-INF/jspf/footer.jspf" %>
</html>
