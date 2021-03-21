<%-- 
    Document   : teamsummary
    Created on : Mar 20, 2021, 8:10:07 PM
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
        <title>ATS - Team</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/navigation.jspf" %>
        <main>
            <div class="container">
                <h1 class="text-center display-4 grey mt-5 mb-5">Summary</h1>
                <c:choose>
                    <c:when test="${ vm.rowsDeleted != null }">
                        <h4>Task deleted Id: <span class="font-weight-bold">${team.id}</span></h4>
                        </c:when>
                        <c:otherwise>
                        <table class="table table-striped">
                            <tbody>
                                <tr>
                                    <td style="text-align: right;">Team Id</td>
                                    <td>${ team.id }</td>
                                </tr>
                                <tr>
                                    <td style="text-align: right;">Team Name</td>
                                    <td>${ team.name }</td>
                                </tr>
                                <tr>
                                    <td style="text-align: right;">Team Member 1</td>
                                    <td>${ emp1 }</td>
                                </tr>
                                <tr>
                                    <td style="text-align: right;">Team Member 2</td>
                                    <td>${ emp2 }</td>
                                </tr>
                                <tr>
                                    <td style="text-align: right;">On Call</td>
                                    <td>${ team.isOnCall }</td>
                                </tr>
                        </table>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>        
    </body>
    <%@include file="WEB-INF/jspf/footer.jspf" %>
</html>