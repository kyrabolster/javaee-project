<%-- 
    Document   : employees
    Created on : 18-Mar-2021, 2:15:23 PM
    Author     : KyraB
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="WEB-INF/jspf/taglibraries.jspf" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="WEB-INF/jspf/header.jspf" %>
        <title>Employee List</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/navigation.jspf" %>
        <main>
            <h1 class="text-center display-4 grey mt-5 mb-5">Employee List</h1>
            <section>
                <div class="container clearfix">
                    <a href="${pageContext.request.contextPath}/employee/create"><button class="btn float-right btn-info mb-2" type="button" >Create New Employee</button></a>
                    <c:set var="employeeCount" value="${ employees.size()}" />
                    <c:choose>
                        <c:when test="${ employeeCount > 0}">
                            <table class="table table-striped">
                                <tr class="bg-dark text-light">
                                    <th>
                                        Id
                                    </th>
                                    <th>
                                        Name
                                    </th>
                                    <th>
                                        SIN
                                    </th>
                                    <th>
                                        Hourly Rate
                                    </th>
                                </tr>
                                <c:forEach items="${employees}"  var="employee">
                                    <tr>
                                        <td><a href="employee/${ employee.id}">${ employee.id}</a></td>
                                        <td>${ employee.firstName } ${ employee.lastName }</td>
                                        <td>${ employee.sin }</td>
                                        <td>${ employee.hourlyRate }</td>
                                    </tr>
                                </c:forEach>
                            </table>
                        </c:when>
                        <c:when test="${ employeeCount == 0}">
                            <hr>
                            <h4 style="text-align:center">No Employees</h4>
                        </c:when>
                    </c:choose>
                </div>
            </section>
        </main>
    </body>
    <%@include file="WEB-INF/jspf/footer.jspf" %>
</html>