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
                    <a href="${pageContext.request.contextPath}/job/create"><button class="btn float-right btn-info mb-2" type="button" >Create New Job</button></a>
                    <c:set var="jobsCount" value="${ jobs.size()}" />
                    <c:choose>
                        <c:when test="${ jobsCount > 0}">
                            <table class="table table-striped">
                                <tr class="bg-dark text-light">
                                    <th>
                                        Id
                                    </th>
                                    <th>
                                        Client Name
                                    </th>
                                    <th>
                                        Start Date
                                    </th>
                                    <th>
                                        End Date
                                    </th>
                                </tr>
                                <c:forEach items="${jobs}"  var="job">
                                    <tr>
                                        <td><a href="job/${ job.id}">${ job.id}</a></td>
                                        <td>${ job.clientName }</td>
                                        <td>${ job.start }</td>
                                        <td>${ job.end }</td>
                                    </tr>
                                </c:forEach>

                            </table>
                        </c:when>
                        <c:when test="${ jobsCount == 0}">
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