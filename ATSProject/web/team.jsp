<%-- 
    Document   : team
    Created on : 19-Mar-2021, 3:37:28 PM
    Author     : Soyoung Kim
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="WEB-INF/jspf/taglibraries.jspf" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="WEB-INF/jspf/header.jspf" %>
        <title>ATS - Team</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/navigation.jspf" %>
        <main>
            <c:choose>
                <c:when test="${team == null || team.id == 0}">
                    <h1 class="text-center display-4 grey mt-5 mb-5">Create Team</h1>
                </c:when>
                <c:otherwise>
                    <h1 class="text-center display-4 grey mt-5 mb-5">Team Details</h1>
                </c:otherwise>
            </c:choose>
            <section>
                <div class="container">
                    <c:set var="errors" value="${error}" />
                    <form method="POST" action="save">
                        <table class="table table-striped">  
                            <c:if test="${team != null && team.id != 0}">
                                <tr>
                                    <td><label>Team Id:</label></td>
                                    <td>
                                        ${team.id}
                                        <input type="hidden" value="${team.id}" name="hdnTeamId" />                                
                                    </td>
                                </tr>
                            </c:if>
                            <tr>                    
                                <td>Team Name</td>
                                <td><input class="form-control" type="text" name="teamName" value='${team.name}'/></td>
                            </tr>
                            <c:choose>
                                <c:when test="${team != null && team.id != 0}">
                                    <c:forEach items="${employeesList}" var="employee" varStatus="status">
                                        <tr>
                                            <td>Team Member ${status.count} </td>
                                            <td>${employee.name}</td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>                    
                                        <td>Team Member 1</td> 
                                        <td><select name="teamMember1">
                                                <option value="0">-- Select Employee --</option>
                                                <c:forEach items="${employeesList}" var="employee">
                                                    <option value="${employee.id}" ${employee.id == emp1.id ? 'selected' : ''}>${employee.name}</option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>                    
                                        <td>Team Member 2</td>

                                        <td><select name="teamMember2">
                                                <option value="0">-- Select Employee --</option>
                                                <c:forEach items="${employeesList}" var="employee">
                                                    <option value="${employee.id}" ${employee.id == emp2.id ? 'selected' : ''}>${employee.name}</option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                            <tr>
                                <td>On Call</td>
                                <td>
                                    <input type="checkbox" class="form-check-input ml-1" id="isOnCall" name="isOnCall" ${team.isOnCall == true ? 'checked' : ''} ${team.isDeleted == true ? 'disabled' : ''} >
                                </td>
                            </tr>
                            <c:if test="${team != null && team.id != 0}">
                                <tr>
                                    <td>Created Date</td>
                                    <td><fmt:formatDate value="${team.createdAt}" pattern = "yyyy-MM-dd HH:mm" /></td>
                                </tr>
                                <c:if test="${team.updatedAt != null}">
                                    <tr>
                                        <td>Updated Date</td>
                                        <td><fmt:formatDate value="${team.updatedAt}" pattern = "yyyy-MM-dd HH:mm" /></td>
                                    </tr>
                                </c:if>
                                <c:if test="${team.deletedAt != null}">
                                    <tr>
                                        <td>Deleted Date</td>
                                        <td><fmt:formatDate value="${team.deletedAt}" pattern = "yyyy-MM-dd HH:mm" /></td>
                                    </tr>
                                </c:if>
                            </c:if>
                        </table>
                        <c:choose>
                            <c:when test="${team != null && team.id != 0}">
                                <input class="btn btn-primary" type="submit" value="Delete" name="action" />
                                <input class="btn btn-primary" type="submit" value="Save" name="action" />     
                            </c:when>
                            <c:otherwise>
                                <input class="btn btn-primary" type="submit" value="Create" name="action" />
                            </c:otherwise>
                        </c:choose>
                    </form>
                    <c:choose>
                        <c:when test="${ team.errors.size() > 0 }">
                            <ul>
                                <c:forEach items="${ team.errors }" var="err">
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