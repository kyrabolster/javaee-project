<%-- 
    Document   : task.jsp
    Created on : 11-Mar-2021, 12:56:05 PM
    Author     : Soyoung Kim
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="WEB-INF/jspf/taglibraries.jspf" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="WEB-INF/jspf/header.jspf" %>
        <title>Creating Task</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/navigation.jspf" %>
        <main>
            <c:choose>
                <c:when test="${task == null || task.id == 0}">
                    <h1 class="text-center display-4 grey mt-5 mb-5">Create Task</h1>
                </c:when>
                <c:otherwise>
                    <h1 class="text-center display-4 grey mt-5 mb-5">Edit Task</h1>
                </c:otherwise>
            </c:choose>
            <section>
                <div class="container">
                    <c:set var="errors" value="${error}" />
                    <form method="POST" action="save">
                        <table class="table table-striped">  
                            <c:if test="${task != null && task.id != 0}">
                                <tr>
                                    <td><label>Task Id:</label></td>
                                    <td>
                                        ${task.id}
                                        <input type="hidden" value="${task.id}" name="hdnTaskId" />                                
                                    </td>
                                </tr>
                            </c:if>
                            <tr>                    
                                <td>Name</td>
                                <td><input class="form-control" type="text" name="taskName" value='${task.name}'/></td>
                            </tr>
                            <tr>                    
                                <td>Description</td>
                                <td><textarea class="form-control" name="taskDesc" rows="3">${task.description}</textarea></td>
                            </tr>
                            <tr>
                                <td>Duration(minutes)</td>
                                <td><input class="form-control" type="number" min="30" step="15" name="taskDuration" value="${task.duration}"/></td>
                            </tr>
                        </table>
                        <c:choose>
                            <c:when test="${task != null && task.id != 0}">
                                <input class="btn btn-primary" type="submit" value="Delete" name="action" />
                                <input class="btn btn-primary" type="submit" value="Save" name="action" />     
                            </c:when>
                            <c:otherwise>
                                <input class="btn btn-primary" type="submit" value="Create" name="action" />
                            </c:otherwise>
                        </c:choose>
                    </form>
                    <c:choose>
                        <c:when test="${ task.errors.size() > 0 }">
                            <ul>
                                <c:forEach items="${ task.errors }" var="err">
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
