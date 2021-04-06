<%-- 
    Document   : jobs
    Created on : Apr 1, 2021, 6:43:23 PM
    Author     : Soyoung Kim
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="WEB-INF/jspf/taglibraries.jspf" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="WEB-INF/jspf/header.jspf" %>
        <title>ATS - Jobs</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/navigation.jspf" %>
        <main>
            <h1 class="text-center display-4 grey mt-5 mb-5">Jobs List</h1>
            <section>
                <div class="container clearfix">
                    <div>
                        <a href="${pageContext.request.contextPath}/job/create"><button class="btn float-right btn-info mb-2" type="button" >Create New Job</button></a>                    
                    </div>
                    <form method="POST" action="">
                        <div class="form-inline mx-sm-3 mb-2">
                            <input class="form-control" name="searchDate" type="date"/> 
                            <input class="btn btn-info ml-2" type="submit" value="Search" name="action" />
                        </div>
                    </form>
                    <c:set var="jobsCount" value="${ jobs.size()}" />
                    <c:choose>
                        <c:when test="${ jobs.size() > 0}">
                            <table class="table table-striped">
                                <tr class="bg-dark text-light">
                                    <th>
                                        Id
                                    </th>
                                    <th>
                                        Client Name
                                    </th>
                                    <th>
                                        Description
                                    </th>
                                    <th>
                                        Start Date
                                    </th>
                                    <th>
                                        End Date
                                    </th>
                                    <th>
                                        Cost
                                    </th>
                                    <th>
                                        Revenue
                                    </th>
                                    <th>
                                        Team
                                    </th>
                                    <th>
                                        Tasks
                                    </th>
                                    <th>
                                        View Details
                                    </th>
                                </tr>
                                <c:forEach items="${jobs}"  var="job">
                                    <tr>
                                        <td>${ job.id}</td>
                                        <td>${ job.clientName }</td>
                                        <td>${ job.description }</td>
                                        <td><fmt:formatDate value="${ job.start }" pattern = "yyyy-MM-dd HH:mm" /></td>
                                        <td><fmt:formatDate value="${ job.end }" pattern = "yyyy-MM-dd HH:mm" /></td>
                                        <td><fmt:formatNumber value="${ job.cost }" type="currency" currencySymbol="$"/></td>
                                        <td><fmt:formatNumber value="${ job.revenue }" type="currency" currencySymbol="$"/></td>
                                        <td>${ job.teamName }</td>
                                        <td>${ job.tasksName }</td>
                                        <td><a href="job/${ job.id}">View Details</a></td>
                                    </tr>
                                </c:forEach>

                            </table>
                        </c:when>
                        <c:when test="${ jobs.size() == 0}">
                            <hr>
                            <h4 style="text-align:center">No Jobs</h4>
                        </c:when>
                    </c:choose>
                </div>
            </section>
        </main>
    </body>
    <%@include file="WEB-INF/jspf/footer.jspf" %>
</html>