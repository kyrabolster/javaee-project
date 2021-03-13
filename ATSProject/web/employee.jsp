<%-- 
    Document   : employee
    Created on : 12-Mar-2021, 7:43:37 PM
    Author     : KyraB
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ATS - Employee</title>
        <%@include file="/WEB-INF/jspf/header.jspf" %>
        <%@include file="/WEB-INF/jspf/navigation.jspf" %>

    </head>
    <body>
        <main>
            <div class="container">
                <h2 class="text-center m-4">Create Employee</h2>
                <div class="row justify-content-center text-right">
                    <form method="POST" action="">
                        <table class="table">               
                            <tr>                    
                                <td>First Name:</td>
                                <td><input type="text" name="firstName"/></td>
                            </tr>
                            <tr>                    
                                <td>Last Name:</td>
                                <td><input type="text" name="lastName" /></td>
                            </tr>
                            <tr>                    
                                <td>SIN:</td>
                                <td><input type="text" name="sin" /></td>
                            </tr>
                            <tr>                    
                                <td>Hourly Rate:</td>
                                <td><input type="text" name="hourlyRate"/></td>
                            </tr>
                        </table>
                        <div class="col text-center">
                            <button name="btnCreateEmployee" class="btn btn-info">Create</button>
                        </div>
                    </form>   
                </div>
            </div>
        </main>        
    </body>
    <%@include file="/WEB-INF/jspf/footer.jspf" %>
</html>
