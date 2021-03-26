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
                    <h1 class="text-center display-4 grey mt-5 mb-5">Edit Job</h1>
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
                                <td><input class="form-control" type="text" name="clicneName" value='${job.clientName}'/></td>
                            </tr>
                            <tr>                    
                                <td>Description</td>
                                <td><textarea class="form-control" name="jobDescription" rows="3">${job.description}</textarea></td>
                            </tr>
                            <tr>
                                <td>Start</td>
                                <td><input class="form-control" type="datetime-local" name="jobStart" value='${job.start}'/></td>
                            </tr>
                            <tr>                            
                                <td>On site</td>
                                <td>
                                    <input type="checkbox" class="form-check-input ml-1" id="isOnSite" ${job.isOnsite == true ? 'checked' : ''}>
                                </td>
                            </tr>
                            <tr>                            
                                <td>Tasks</td>
                                <td>
                                    <input type="checkbox" class="form-check-input ml-1" id="task">
                                    <label class="form-check-label ml-4" for="task1">Task 1</label>
                                    <input type="checkbox" class="form-check-input ml-1" id="task">
                                    <label class="form-check-label ml-4" for="task2">Task 2</label>
                                    <input type="checkbox" class="form-check-input ml-1" id="task">
                                    <label class="form-check-label ml-4" for="task3">Task 3</label>
                                    <input type="checkbox" class="form-check-input ml-1" id="task">
                                    <label class="form-check-label ml-4" for="task4">Task 4</label>
                                </td>
                            </tr>
                        </table>
                                <input class="btn btn-primary" type="submit" value="Search Team" name="action" />
                                <input class="btn btn-primary" type="submit" value="Reset" name="action" />
                        <c:choose>
                            <c:when test="${job != null && job.id}">
                                <input class="btn btn-primary" type="submit" value="Delete" name="action" />
                                <input class="btn btn-primary" type="submit" value="Save" name="action" />     
                            </c:when>
                            <c:when test="${job.team == null}">
                                <table class="table table-striped mt-5">
                                    <tr>
                                        <th>
                                            Select
                                        </th>
                                        <th>
                                            Team Name
                                        </th>
                                        <th>
                                            Member 1
                                        </th>
                                        <th>
                                            Member 2
                                        </th>
                                        <th>
                                            Duration
                                        </th>
                                    </tr>
                                    <tr>
                                        <td>
                                            <input type='radio' name='isSelecteTeam'>
                                        </td>
                                        <td>
                                            First Team
                                        </td>
                                        <td>
                                            Sam Smith
                                        </td>
                                        <td>
                                            Jennifer Brown
                                        </td>
                                        <td>
                                            90 minutes
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <input type='radio' name='isSelecteTeam'>
                                        </td>
                                        <td>
                                            First Team
                                        </td>
                                        <td>
                                            Sam Smith
                                        </td>
                                        <td>
                                            Jennifer Brown
                                        </td>
                                        <td>
                                            60 minutes
                                        </td>
                                    </tr>
                                </table>
                                <input class="btn btn-primary" type="submit" value="Create" name="action" />
                            </c:when>
                        </c:choose>
                    </form>
                    <c:choose>
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
