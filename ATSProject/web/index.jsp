<%-- 
    Document   : index
    Created on : 9-Mar-2021, 8:26:47 PM
    Author     : KyraB
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="WEB-INF/jspf/taglibraries.jspf" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ATS - Home Page</title>
        <%@include file="/WEB-INF/jspf/header.jspf" %>
        <%@include file="/WEB-INF/jspf/navigation.jspf" %>
        <%@include file="/WEB-INF/jspf/revenueCharts.jspf" %>
    </head>
    <body>
        <div class="card" style="width: 18rem;">
            <div class="card-body">
                <h5 class="card-title font-weight-bold text-info mb-2">TEAM ON CALL</h5>
                <h4 class="card-subtitle mb-2 text-muted">${ teamOnCall.name}</h4>
            </div>
        </div>

        <div class="card" style="width: 18rem;">
            <div class="card-body">
                <h5 class="card-title font-weight-bold text-info mb-2">No. JOBS TODAY</h5>
                <h4 class="card-subtitle mb-2 text-muted">${ numJobsToday }</h4>
            </div>
        </div>

        <div class="card" style="width: 18rem;">
            <div class="card-body">
                <h5 class="card-title font-weight-bold text-info mb-2">TOTAL COST THIS MONTH</h5>
                <h4 class="card-subtitle mb-2 text-muted"><fmt:formatNumber value="${ costThisMonth }" type="currency" currencySymbol="$"/></h4>
            </div>
        </div>

        <div class="card" style="width: 18rem;">
            <div class="card-body">
                <h5 class="card-title font-weight-bold text-info mb-2">TOTAL REVENUE THIS MONTH</h5>
                <h4 class="card-subtitle mb-2 text-muted"><fmt:formatNumber value="${ revenueThisMonth }" type="currency" currencySymbol="$"/></h4>
            </div>
        </div>

        <div class="card" style="width: 18rem;">
            <div class="card-body">
                <h5 class="card-title font-weight-bold text-info mb-2">TOTAL BILLABLE THIS MONTH</h5>
                <h4 class="card-subtitle mb-2 text-muted"><fmt:formatNumber value="${ billableThisMonth }" type="currency" currencySymbol="$"/></h4>
            </div>
        </div>

        <div id="chartContainer" class="m-auto" style="height: 370px; width: 50%;"></div>
    </body>
    <%@include file="/WEB-INF/jspf/footer.jspf" %>
</html>
