<%-- 
    Document   : task.jsp
    Created on : 11-Mar-2021, 12:56:05 PM
    Author     : Soyoung Kim
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
            <h1 class="text-center display-4 grey mt-5 mb-5">Create Task</h1>
            <section>
                
            <div class="container">
                <form method="POST" action="save">
                    <table class="table table-striped">  
                        <!--<tr> for edit/delete task
                            <td><label>Task Id:</label></td>
                            <td>
                                <input type="hidden" value="" name="hdnInvoiceId" />                                
                            </td>
                        </tr>-->
                        <tr>                    
                            <td>Name:</td>
                            <td><input class="form-control" type="text" name="taskName" value=''/></td>
                        </tr>
                        <tr>                    
                            <td>Description</td>
                            <td><textarea class="form-control" name="taskDesc" rows="3"></textarea></td>
                        </tr>
                        <tr>
                            <td>Duration(minutes)</td>
                            <td><input class="form-control" type="number" min="30" step="15" name="taskDuration" /></td>
                        </tr>
                    </table>

<!--                    <input class="btn btn-primary" type="submit" value="Delete" name="action" />
                    <input class="btn btn-primary" type="submit" value="Save" name="action" />     -->
                    <input class="btn btn-primary" type="submit" value="Create" name="action" />
                </form>
                
            </div>
            </section>
        </main>
    </body>
    <%@include file="WEB-INF/jspf/footer.jspf" %>
</html>
