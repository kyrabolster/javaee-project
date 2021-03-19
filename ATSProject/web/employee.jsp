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
            <c:choose>
                <c:when test="${employee == null || employee.id == 0}">
                    <h1 class="text-center display-4 grey mt-5 mb-5">Create Employee</h1>
                </c:when>
                <c:otherwise>
                    <h1 class="text-center display-4 grey mt-5 mb-5">Edit Employee</h1>
                </c:otherwise>
            </c:choose>
            <section>
                <div class="container">
                    <c:set var="errors" value="${error}" />
                    <form method="POST" action="save">
                        <table class="table table-striped">    
                            <c:if test="${employee != null && employee.id != 0}">
                                <tr>
                                    <td><label>Employee Id:</label></td>
                                    <td>
                                        ${employee.id}
                                        <input type="hidden" value="${employee.id}" name="hdnEmployeeId" />                                
                                    </td>
                                </tr>
                            </c:if>
                            <tr>                    
                                <td>First Name:</td>
                                <td><input type="text" name="firstName" value='${employee.firstName}'/></td>
                            </tr>
                            <tr>                    
                                <td>Last Name:</td>
                                <td><input type="text" name="lastName" value='${employee.lastName}' /></td>
                            </tr>
                            <tr>                    
                                <td>SIN:</td>
                                <td><input type="text" name="sin" value='${employee.sin}'/></td>
                            </tr>
                            <tr>                    
                                <td>Hourly Rate:</td>
                                <td><input type="text" name="hourlyRate" value='${employee.hourlyRate}'/></td>
                            </tr>
                        </table>
                        <c:choose>
                            <c:when test="${employee != null && employee.id != 0}">
                                <input class="btn btn-primary" type="submit" value="Delete" name="action" />
                                <input class="btn btn-primary" type="submit" value="Save" name="action" />     
                            </c:when>
                            <c:otherwise>
                                <input class="btn btn-primary" type="submit" value="Create" name="action" />
                            </c:otherwise>
                        </c:choose>
                    </form>  
                    <c:choose>
                        <c:when test="${ employee.errors.size() > 0 }">
                            <ul>
                                <c:forEach items="${ employee.errors }" var="err">
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
    <%@include file="/WEB-INF/jspf/footer.jspf" %>
</html>
