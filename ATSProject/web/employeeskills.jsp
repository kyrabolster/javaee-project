<%-- 
    Document   : employee
    Created on : 12-Mar-2021, 7:43:37 PM
    Author     : KyraB
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="WEB-INF/jspf/taglibraries.jspf" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ATS - Create Employee</title>
        <%@include file="/WEB-INF/jspf/header.jspf" %>
        <%@include file="/WEB-INF/jspf/navigation.jspf" %>

    </head>
    <body>
        <main>
            <h1 class="text-center display-4 grey mt-5 mb-5">Update Employee Skills</h1>
            <section>
                <div class="container">
                    <c:set var="errors" value="${ error }" />
                    <form method="POST" action="save">
                        <input type="hidden" value="${ employee.id }" name="hdnEmployeeId" />                                
                        <table class="table table-striped">  
                            <tr>                    
                                <td>
                                    Employee Name: ${ employee.firstName } ${ employee.lastName }
                                </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>
                                    <p>Select Skills to Add:</p>
                                    <c:choose>
                                        <c:when test="${tasksToAdd.size() <= 0}">
                                            <i>No remaining skills to be added</i>
                                        </c:when>
                                        <c:otherwise>
                                            <select multiple name="taskToAdd">
                                                <c:forEach items="${tasksToAdd}" var="task">
                                                    <!-- check for duplicates *** -->
                                                    <option value="${task.id}" >${task.name}</option>
                                                </c:forEach>
                                            </select>
                                            <div>
                                                <input class="btn btn-primary" type="submit" value="Add Skill" name="action" />     
                                            </div>
                                        </c:otherwise>
                                    </c:choose>   
                                </td>
                                <td>
                                    <p>Current Skills:</p>
                                    <c:choose>
                                        <c:when test="${employee.tasks.size() <= 0}">
                                            <i>No skills assigned currently</i>
                                        </c:when>
                                        <c:otherwise>
                                            <select multiple name="taskSelect">
                                                <c:forEach items="${employee.tasks}" var="task">
                                                    <!-- check for duplicates *** -->
                                                    <option value="${task.id}" >${task.name}</option>
                                                </c:forEach>
                                            </select>
                                            <div>
                                                <input class="btn btn-primary" type="submit" value="Remove Skill" name="action" />     
                                            </div>
                                        </c:otherwise>
                                    </c:choose>   
                                </td>
                            </tr>
                        </table>
                    </form>  
                    <c:choose>
                        <c:when test="${ employee.errors.size() > 0 }">
                            <ul>
                                <c:forEach items="${ employee.errors }" var="err">
                                    <li>Error Code: ${ err.code } Error Desc: ${ err.description }</li>
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
    <%@include file="/WEB-INF/jspf/footer.jspf" %>
</html>
