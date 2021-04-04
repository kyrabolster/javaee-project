<%-- 
    Document   : job
    Created on : Mar 23, 2021, 12:12:13 PM
    Author     : Soyoung Kim
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="WEB-INF/jspf/taglibraries.jspf" %>
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
            <c:choose>
                <c:when test="${job == null || job.id == 0}">
                    <h1 class="text-center display-4 grey mt-5 mb-5">Create Job</h1>
                </c:when>
                <c:otherwise>
                    <h1 class="text-center display-4 grey mt-5 mb-5">Job Details</h1>
                </c:otherwise>
            </c:choose>
            <section>
                <div class="container">
                    <c:set var="errors" value="${error}" />
                    <form method="POST" action="save">
                        <table class="table table-striped">  
                            <c:if test="${job != null && job.id != 0}">
                                <tr>
                                    <td>Job Id:</td>
                                    <td>
                                        ${job.id}
                                        <input type="hidden" value="${job.id}" name="hdnJobId" />                                
                                    </td>
                                </tr>
                            </c:if>
                            <tr>                    
                                <td>Client Name</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${(teams.size() == 0 || teams == null) && team == null}">
                                            <input class="form-control" type="text" name="clientName" value='${job.clientName}'/>
                                        </c:when>
                                        <c:otherwise>
                                            <p>${job.clientName}</p>
                                            <input class="form-control" type="hidden" name="clientName" value='${job.clientName}'/>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <tr>                    
                                <td>Description</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${(teams.size() == 0 || teams == null) && team == null}">
                                            <textarea class="form-control" name="jobDescription" rows="3">${job.description}</textarea>
                                        </c:when>
                                        <c:otherwise>
                                            <p>${job.description}</p>
                                            <input class="form-control" type="hidden" name="jobDescription" value='${job.description}'/>
                                        </c:otherwise>
                                    </c:choose>                                    
                                </td>
                            </tr>
                            <tr>
                                <td>Start</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${(teams.size() == 0 || teams == null) && team == null}">
                                            <input class="form-control" name="jobStart" type="datetime-local" id ='datetimepicker' value='${job.start}'/>
                                        </c:when>
                                        <c:otherwise>
                                            <p><fmt:formatDate value="${ job.start }" pattern = "yyyy-MM-dd HH:mm" /></p>
                                            <input class="form-control" type="hidden" name="jobStart" value='${job.start}'/>
                                        </c:otherwise>
                                    </c:choose>      
                                </td>
                            </tr>
                            <c:if test="${job != null && job.id > 0 && team != null}">
                                <tr>
                                    <td>End</td>
                                    <td><fmt:formatDate value="${ job.end }" pattern = "yyyy-MM-dd HH:mm" /></td>
                                </tr>
                            </c:if>

                            <c:if test="${job == null || job.id == 0}">
                                <tr>                            
                                    <td>On site</td>
                                    <td>
                                        <input type="checkbox" class="form-check-input ml-1" name="isOnSite" ${job.isOnSite == true ? 'checked' : ''} ${teams.size() > 0 || team != null ? 'disabled' : ''}>
                                        <c:if test="${teams != null}">
                                            <input class="form-control" type="hidden" name="isOnSite" value="${job.isOnSite == true ? 'checked' : ''}"/>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:if>
                            <tr>                            
                                <td>Tasks</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${(teams.size() == 0 || teams == null) && team == null}">
                                            <c:forEach items="${tasks}" var="task">
                                                <input type="checkbox" class="form-check-input ml-1" name="task" value="${task.id}">
                                                <label class="form-check-label ml-4">${task.name}</label>
                                                <br>
                                            </c:forEach>
                                        </c:when>
                                        <c:when test="${team != null}">
                                            <p>${job.tasksName}</p>
                                        </c:when>  
                                        <c:otherwise>
                                            <c:forEach items="${job.tasks}" var="task">
                                                <p>${task}</p>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>     
                                </td>
                            </tr>
                            <c:if test="${job != null && job.id > 0 && team != null}">
                                <tr>
                                    <td>Cost</td>
                                    <td><fmt:formatNumber value="${ job.cost }" type="currency" currencySymbol="$"/></td>
                                </tr>
                                <tr>
                                    <td>Revenue</td>
                                    <td><fmt:formatNumber value="${ job.revenue }" type="currency" currencySymbol="$"/></td>
                                </tr>
                                <tr>
                                    <td>Team Member</td>
                                    <td>
                                        <c:forEach items="${team.teamMembers}" var="member">
                                            <p>${member.firstName} ${member.lastName}</p>
                                        </c:forEach>
                                    </td>
                                </tr>
                            </c:if>

                        </table>
                        <c:choose>
                            <c:when test="${(teams == null || teams.size() == 0) && team == null}">
                                <input class="btn btn-primary" type="submit" value="SearchTeam" name="action" />
                            </c:when>
                            <c:when test="${teams != null || teams.size() > 0}">
                                <input class="btn btn-primary" type="submit" value="Reset" name="action" />
                            </c:when>
                            <c:when test="${job != null && job.id > 0 && team != null}">
                                <input class="btn btn-primary" type="submit" value="Delete" name="action" />
                            </c:when>
                        </c:choose>
                        <c:choose>
                            <c:when test="${teams.size() > 0}">
                                <table class="table table-striped mt-5">
                                    <tr>
                                        <th>
                                            Select
                                        </th>
                                        <th>
                                            Team Name
                                        </th>
                                        <th>
                                            Start Date
                                        </th>
                                        <th>
                                            End Date
                                        </th>
                                        <th>
                                            Total Duration
                                        </th>
                                        <th>
                                        </th>
                                    </tr>

                                    <c:forEach items="${teams}" var="team">
                                        <tr>
                                            <td>
                                                <input type='radio' name='isSelecteTeam' value="${team.id}">
                                            </td>
                                            <td>
                                                ${team.teamName}
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${team.start}" pattern = "yyyy-MM-dd HH:mm" />                                                
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${team.end}" pattern = "yyyy-MM-dd HH:mm" />
                                            </td>
                                            <td>
                                                ${team.totalDuration}
                                            </td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/team/${team.id}">Team Details</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </table>
                                <input class="btn btn-primary" type="submit" value="Create" name="action" />
                            </c:when>
                        </c:choose>
                    </form>
                    <c:choose>
                        <c:when test="${teams.size() == 0}">
                            <ul>
                                <li>No teams available</li>                            
                            </ul>
                        </c:when>
                        <c:when test="${ job.errors.size() > 0 }">
                            <ul>
                                <c:forEach items="${ job.errors }" var="err">
                                    <li>Error Code: ${ err.code } Error Desc: ${err.description }</li>
                                    </c:forEach>
                            </ul>
                        </c:when>
                        <c:when test="${ error != null }">
                            <ul>
                                <c:forEach items="${ error.errors }" var="err">
                                    <li>${ err }</li>
                                    </c:forEach>
                            </ul>
                        </c:when>
                    </c:choose>
                </div>
            </section>
        </main>
    </body>
    <%@include file="WEB-INF/jspf/footer.jspf" %>
</html>

