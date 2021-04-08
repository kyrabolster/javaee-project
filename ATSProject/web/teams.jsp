<%-- 
    Document   : teams
    Created on : Mar 20, 2021, 9:13:34 PM
    Author     : Soyoung Kim
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="WEB-INF/jspf/taglibraries.jspf" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="WEB-INF/jspf/header.jspf" %>
        <title>ATS - Teams</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/navigation.jspf" %>
        <main>
            <h1 class="text-center display-4 grey mt-5 mb-5">Teams List</h1>
            <section>
                <div class="container clearfix">
                    <a href="${pageContext.request.contextPath}/team/create"><button class="btn float-right btn-info mb-2" type="button" >Create New Team</button></a>
                    <c:choose>
                        <c:when test="${ teams.size() > 0}">
                            <table class="table table-striped">
                                <tr class="bg-dark text-light">
                                    <th>
                                        Id
                                    </th>
                                    <th>
                                        Name
                                    </th>
                                    <th>
                                        Team Member
                                    </th>
                                    <th>
                                        On Call
                                    </th>
                                    <th>
                                        Status
                                    </th>   
                                     <th>
                                        Details
                                    </th>
                                </tr>
                                <c:forEach items="${teams}"  var="team">
                                    <tr>
                                        <td>${team.id}</td>
                                        <td>${team.name}</td>
                                        <td>${team.members}</td>
                                        <td>${team.isOnCall == true ? "<span class='fa fa-check'></span>" : ""}</td>
                                        <td>${team.isDeleted == true ? "Deleted": ""}</td>
                                        <td><a href="team/${team.id}">View Details</a></td>
                                    </tr>
                                </c:forEach>

                            </table>
                        </c:when>
                        <c:when test="${ teams.size() == 0}">
                            <hr>
                            <h4 style="text-align:center">No Teams</h4>
                        </c:when>
                    </c:choose>
                </div>
            </section>
        </main>
    </body>
    <%@include file="WEB-INF/jspf/footer.jspf" %>
</html>