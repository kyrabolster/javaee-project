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
        <div class="m-5 text-muted text-center">
            <h1>Advanced Technology Solutions</h1>
        </div>

        <div class="card-group m-4 justify-content-center">
            <div class="card border-left shadow-sm mr-3" style="max-width: 18rem;">
                <div class="card-body">
                    <h5 class="card-title font-weight-bold text-info mb-2">TEAM ON CALL</h5>
                    <h4 class="card-subtitle mb-2 text-muted">${ teamOnCall.name}</h4>
                </div>
            </div>

            <div class="card border-left shadow-sm mr-3" style="max-width: 18rem;">
                <div class="card-body">
                    <h5 class="card-title font-weight-bold text-info mb-2">No. JOBS TODAY</h5>
                    <h4 class="card-subtitle mb-2 text-muted">${ numJobsToday }</h4>
                </div>
            </div>
        </div>
        <div class="card-group m-4 justify-content-center">
            <div class="card border-left shadow-sm mr-3" style="max-width: 18rem;">
                <div class="card-body">
                    <h5 class="card-title font-weight-bold text-info mb-2">TOTAL COST THIS MONTH</h5>
                    <h4 class="card-subtitle mb-2 text-muted"><fmt:formatNumber value="${ costThisMonth }" type="currency" currencySymbol="$"/></h4>
                </div>
            </div>

            <div class="card border-left shadow-sm mr-3" style="max-width: 18rem;">
                <div class="card-body">
                    <h5 class="card-title font-weight-bold text-info mb-2">TOTAL REVENUE THIS MONTH</h5>
                    <h4 class="card-subtitle mb-2 text-muted"><fmt:formatNumber value="${ revenueThisMonth }" type="currency" currencySymbol="$"/></h4>
                </div>
            </div>

            <div class="card border-left shadow-sm mr-3" style="max-width: 18rem;">
                <div class="card-body">
                    <h5 class="card-title font-weight-bold text-info mb-2">TOTAL BILLABLE THIS MONTH</h5>
                    <h4 class="card-subtitle mb-2 text-muted"><fmt:formatNumber value="${ billableThisMonth }" type="currency" currencySymbol="$"/></h4>
                </div>
            </div>
        </div>

        <div class="card-group m-4 justify-content-center">
            <div class="card border-left shadow-sm mr-3" style="max-width: 18rem;">
                <div class="card-body">
                    <h5 class="card-title font-weight-bold text-info mb-2">TOTAL COST THIS YEAR</h5>
                    <h4 class="card-subtitle mb-2 text-muted"><fmt:formatNumber value="${ costThisYear}" type="currency" currencySymbol="$"/></h4>
                </div>
            </div>

            <div class="card border-left shadow-sm mr-3" style="max-width: 18rem;">
                <div class="card-body">
                    <h5 class="card-title font-weight-bold text-info mb-2">TOTAL REVENUE THIS YEAR</h5>
                    <h4 class="card-subtitle mb-2 text-muted"><fmt:formatNumber value="${ revenueThisYear }" type="currency" currencySymbol="$"/></h4>
                </div>
            </div>

            <div class="card border-left shadow-sm mr-3" style="max-width: 18rem;">
                <div class="card-body">
                    <h5 class="card-title font-weight-bold text-info mb-2">TOTAL BILLABLE THIS YEAR</h5>
                    <h4 class="card-subtitle mb-2 text-muted"><fmt:formatNumber value="${ billableThisYear }" type="currency" currencySymbol="$"/></h4>
                </div>
            </div>
        </div>

        <div id="thisYearChart" class="mx-auto mt-5" style="height: 370px; width: 50%;"></div>
        <div id="lastYearChart" class="mx-auto mt-5" style="height: 370px; width: 50%;"></div>
    </body>
    <%@include file="/WEB-INF/jspf/footer.jspf" %>
</html>
