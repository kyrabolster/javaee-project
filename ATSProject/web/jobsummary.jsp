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

                <c:if test="${ vm.rowsDeleted != null }">
                    <h4>${ deleteMessage }</h4>
                    <h4>Job deleted Id: <span class="font-weight-bold">${job.id}</span></h4>
                    </c:if>
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
                            <td><fmt:formatDate value="${ job.start }" pattern = "yyyy-MM-dd HH:mm" /></td>
                        </tr>
                        <tr>
                            <td style="text-align: right;">End Date</td>
                            <td><fmt:formatDate value="${ job.end }" pattern = "yyyy-MM-dd HH:mm" /></td>
                        </tr>
                        <tr>
                            <td style="text-align: right;">Tasks</td>
                            <td>
                                <p>${job.tasksName}</p>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: right;">Cost</td>
                            <td><fmt:formatNumber value="${ job.cost }" type="currency" currencySymbol="$"/></td>
                        </tr>
                        <tr>
                            <td style="text-align: right;">Revenue</td>
                            <td><fmt:formatNumber value="${ job.revenue }" type="currency" currencySymbol="$"/></td>
                        </tr>
                </table>
                <a href="/ATSProject/jobs">Back to Job List</a>
            </div>
        </main>        
    </body>
    <%@include file="WEB-INF/jspf/footer.jspf" %>
</html>