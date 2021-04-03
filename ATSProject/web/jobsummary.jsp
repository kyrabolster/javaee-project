<%-- 
    Document   : jobsummary
    Created on : Apr 1, 2021, 6:43:23 PM
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
        <title>ATS - Job</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/navigation.jspf" %>
        <main>
            <div class="container">
                <h1 class="text-center display-4 grey mt-5 mb-5">Summary</h1>
                <c:choose>
                    <c:when test="${ vm.rowsDeleted != null }">
                        <h4>Job deleted Id: <span class="font-weight-bold">${job.id}</span></h4>
                        </c:when>
                        <c:otherwise>
                        <table class="table table-striped">
                            <tbody>
                                <tr>
                                    <td style="text-align: right;">Team Name</td>
                                    <td>${ team.teamName }</td>
                                </tr>
                                <tr>
                                    <td style="text-align: right;">Client Name</td>
                                    <td>${ job.clientName }</td>
                                </tr>
                                <tr>
                                    <td style="text-align: right;">Description</td>
                                    <td>${ job.description }</td>
                                </tr>
                                <tr>
                                    <td style="text-align: right;">Start Date</td>
                                    <td>${job.start}</td>
                                </tr>
                                <tr>
                                    <td style="text-align: right;">End Date</td>
                                    <td>${team.end}</td>
                                </tr>
                                <tr>
                                    <td style="text-align: right;">Tasks</td>
                                    <td>
                                        <c:forEach items="${tasks}" var="task">
                                            <p>${task}</p>
                                        </c:forEach>
                                    </td>
                                </tr>
                        </table>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>        
    </body>
    <%@include file="WEB-INF/jspf/footer.jspf" %>
</html>