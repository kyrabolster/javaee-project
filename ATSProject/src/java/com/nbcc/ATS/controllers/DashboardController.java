/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATS.controllers;

import com.nbcc.ATSsystem.business.IJobService;
import com.nbcc.ATSsystem.business.ITeamService;
import com.nbcc.ATSsystem.business.JobServiceFactory;
import com.nbcc.ATSsystem.business.TeamServiceFactory;
import com.nbcc.ATSsystem.models.IJob;
import java.io.IOException;
import java.util.Calendar;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author KyraB
 */
public class DashboardController extends CommonController {

    private static final String DASHBOARD_VIEW = "/index.jsp";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int currentYear = Calendar.getInstance().get(Calendar.YEAR);
        int currentMonth = Calendar.getInstance().get(Calendar.MONTH) + 1;
        
        double costThisMonth = 0.0;
        double revenueThisMonth = 0.0;
        double billableThisMonth = 0.0;

        ITeamService teamService = TeamServiceFactory.createInstance();
        IJobService jobService = JobServiceFactory.createInstance();

        
        request.setAttribute("currentYear", currentYear);

        request.setAttribute("teamOnCall", teamService.getTeamOnCall());
        request.setAttribute("numJobsToday", jobService.getNumJobsToday());

        for (IJob job : jobService.getJobsByMonth(currentMonth, currentYear)) {
            costThisMonth += job.getCost();
            revenueThisMonth += job.getRevenue();
        }
        
        billableThisMonth = revenueThisMonth + costThisMonth;
        
        request.setAttribute("costThisMonth", costThisMonth);
        request.setAttribute("revenueThisMonth", revenueThisMonth);
        request.setAttribute("billableThisMonth", billableThisMonth);

        super.setView(request, DASHBOARD_VIEW);

        super.getView().forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

}
