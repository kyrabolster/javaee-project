<%-- 
    Document   : tasks.jsp
    Created on : 11-Mar-2021, 12:55:51 PM
    Author     : Soyoung Kim
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="WEB-INF/jspf/taglibraries.jspf" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="WEB-INF/jspf/header.jspf" %>
        <title>Tasks List</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/navigation.jspf" %>
        <main>
            <h1 class="text-center display-4 grey mt-5 mb-5">Tasks List</h1>
            <section>
                <div class="container clearfix">
                    <a href="${pageContext.request.contextPath}/task/create"><button class="btn float-right btn-info mb-2" type="button" >Create New Task</button></a>
                    <c:set var="taskCount" value="${ tasks.size()}" />
                    <c:choose>
                        <c:when test="${ taskCount > 0}">
                            <table class="table table-striped">
                                <tr class="bg-dark text-light">
                                    <th>
                                        Id
                                    </th>
                                    <th>
                                        Name
                                    </th>
                                    <th>
                                        Description
                                    </th>
                                </tr>
                                <c:forEach items="${tasks}"  var="task">
                                    <tr>
                                        <td><a href="task/${ task.id}">${ task.id}</a></td>
                                        <td>${ task.name }</td>
                                        <td>${ task.description }</td>
                                    </tr>
                                </c:forEach>

                            </table>
                        </c:when>
                        <c:when test="${ taskCount == 0}">
                            <hr>
                            <h4 style="text-align:center">No Tasks</h4>
                        </c:when>
                    </c:choose>
                </div>
            </section>
        </main>
    </body>
    <%@include file="WEB-INF/jspf/footer.jspf" %>
</html>
