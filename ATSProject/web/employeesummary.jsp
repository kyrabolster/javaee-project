<%-- 
    Document   : employeesummary
    Created on : 18-Mar-2021, 2:18:45 PM
    Author     : KyraB
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="WEB-INF/jspf/taglibraries.jspf" %>
<c:set var="vm" value="${vm}" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="WEB-INF/jspf/header.jspf" %>
        <title>ATS - Employee Info</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/navigation.jspf" %>
        <main>
            <div class="container">
                <h1 class="text-center display-4 grey mt-5 mb-5">Summary</h1>
                <h4>${ message }</h4>
                <c:choose>
                    <c:when test="${ vm.rowsDeleted != null }">
                        <h4>Employee deleted Id: <span class="font-weight-bold">${employee.id}</span></h4>
                        </c:when>
                        <c:otherwise>
                        <table class="table table-striped">
                            <tbody>
                                <tr>
                                    <td style="text-align: right;">Employee Id</td>
                                    <td>${ employee.id }</td>
                                </tr>
                                <tr>
                                    <td style="text-align: right;">Employee Name</td>
                                    <td>${ employee.firstName } ${ employee.lastName }</td>
                                </tr>
                                <tr>
                                    <td style="text-align: right;">Employee SIN</td>
                                    <td>${ employee.SIN }</td>
                                </tr>
                                <tr>
                                    <td style="text-align: right;">Employee Hourly Rate</td>
                                    <td><fmt:formatNumber value="${ employee.hourlyRate}" type="currency" currencySymbol="$"/></td>
                                </tr>
                        </table>
                        <a href="/ATSProject/employees">Back to Employee List</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </main>        
    </body>
    <%@include file="WEB-INF/jspf/footer.jspf" %>
</html>