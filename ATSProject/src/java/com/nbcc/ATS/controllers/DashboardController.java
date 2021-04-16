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
import java.util.stream.IntStream;
import javax.servlet.ServletException;
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
        int lastYear = currentYear - 1;
        int currentMonth = Calendar.getInstance().get(Calendar.MONTH) + 1;

        int months[] = IntStream.rangeClosed(1, 12).toArray();

        double revenuesThisYear[] = new double[12];
        double costsThisYear[] = new double[12];

        double revenuesLastYear[] = new double[12];
        double costsLastYear[] = new double[12];

        double costThisMonth = 0.0;
        double revenueThisMonth = 0.0;
        double billableThisMonth = 0.0;

        double costThisMonthGraph = 0.0;
        double revenueThisMonthGraph = 0.0;

        double costThisMonthGraphLY = 0.0;
        double revenueThisMonthGraphLY = 0.0;

        double costThisYear = 0.0;
        double revenueThisYear = 0.0;
        double billableThisYear = 0.0;

        ITeamService teamService = TeamServiceFactory.createInstance();
        IJobService jobService = JobServiceFactory.createInstance();

        request.setAttribute("currentYear", currentYear);
        request.setAttribute("lastYear", lastYear);

        request.setAttribute("teamOnCall", teamService.getTeamOnCall());
        request.setAttribute("numJobsToday", jobService.getNumJobsToday());

        for (IJob job : jobService.getJobsByMonth(currentMonth, currentYear)) {
            costThisMonth += job.getCost();
            revenueThisMonth += job.getRevenue();
        }

        for (IJob job : jobService.getJobsByYear(currentYear)) {
            costThisYear += job.getCost();
            revenueThisYear += job.getRevenue();
        }

        billableThisMonth = revenueThisMonth + costThisMonth;
        billableThisYear = revenueThisYear + costThisYear;

        request.setAttribute("costThisMonth", costThisMonth);
        request.setAttribute("revenueThisMonth", revenueThisMonth);
        request.setAttribute("billableThisMonth", billableThisMonth);

        request.setAttribute("costThisYear", costThisYear);
        request.setAttribute("revenueThisYear", revenueThisYear);
        request.setAttribute("billableThisYear", billableThisYear);

        // revenue Chart - This Year
        for (int month : months) {
            costThisMonthGraph = 0.0;
            revenueThisMonthGraph = 0.0;
            for (IJob job : jobService.getJobsByMonth(month, currentYear)) {
                costThisMonthGraph += job.getCost();
                revenueThisMonthGraph += job.getRevenue();
            }

            costsThisYear[month - 1] = costThisMonthGraph;
            revenuesThisYear[month - 1] = revenueThisMonthGraph;
        }

//        request.setAttribute("months", months);
//        request.setAttribute("costsThisYear", costsThisYear);
//        request.setAttribute("revenuesThisYear", revenuesThisYear);
//        
        request.setAttribute("rjan", revenuesThisYear[0]);
        request.setAttribute("rfeb", revenuesThisYear[1]);
        request.setAttribute("rmar", revenuesThisYear[2]);
        request.setAttribute("rapr", revenuesThisYear[3]);
        request.setAttribute("rmay", revenuesThisYear[4]);
        request.setAttribute("rjun", revenuesThisYear[5]);
        request.setAttribute("rjul", revenuesThisYear[6]);
        request.setAttribute("raug", revenuesThisYear[7]);
        request.setAttribute("rsep", revenuesThisYear[8]);
        request.setAttribute("roct", revenuesThisYear[9]);
        request.setAttribute("rnov", revenuesThisYear[10]);
        request.setAttribute("rdec", revenuesThisYear[11]);

        request.setAttribute("cjan", costsThisYear[0]);
        request.setAttribute("cfeb", costsThisYear[1]);
        request.setAttribute("cmar", costsThisYear[2]);
        request.setAttribute("capr", costsThisYear[3]);
        request.setAttribute("cmay", costsThisYear[4]);
        request.setAttribute("cjun", costsThisYear[5]);
        request.setAttribute("cjul", costsThisYear[6]);
        request.setAttribute("caug", costsThisYear[7]);
        request.setAttribute("csep", costsThisYear[8]);
        request.setAttribute("coct", costsThisYear[9]);
        request.setAttribute("cnov", costsThisYear[10]);
        request.setAttribute("cdec", costsThisYear[11]);

        // revenue Chart - Last Year
        for (int month : months) {
            costThisMonthGraphLY = 0.0;
            revenueThisMonthGraphLY = 0.0;
            for (IJob job : jobService.getJobsByMonth(month, lastYear)) {
                costThisMonthGraphLY += job.getCost();
                revenueThisMonthGraphLY += job.getRevenue();
            }

            costsLastYear[month - 1] = costThisMonthGraphLY;
            revenuesLastYear[month - 1] = revenueThisMonthGraphLY;
        }

        request.setAttribute("rjanLY", revenuesLastYear[0]);
        request.setAttribute("rfebLY", revenuesLastYear[1]);
        request.setAttribute("rmarLY", revenuesLastYear[2]);
        request.setAttribute("raprLY", revenuesLastYear[3]);
        request.setAttribute("rmayLY", revenuesLastYear[4]);
        request.setAttribute("rjunLY", revenuesLastYear[5]);
        request.setAttribute("rjulLY", revenuesLastYear[6]);
        request.setAttribute("raugLY", revenuesLastYear[7]);
        request.setAttribute("rsepLY", revenuesLastYear[8]);
        request.setAttribute("roctLY", revenuesLastYear[9]);
        request.setAttribute("rnovLY", revenuesLastYear[10]);
        request.setAttribute("rdecLY", revenuesLastYear[11]);

        request.setAttribute("cjanLY", costsLastYear[0]);
        request.setAttribute("cfebLY", costsLastYear[1]);
        request.setAttribute("cmarLY", costsLastYear[2]);
        request.setAttribute("caprLY", costsLastYear[3]);
        request.setAttribute("cmayLY", costsLastYear[4]);
        request.setAttribute("cjunLY", costsLastYear[5]);
        request.setAttribute("cjulLY", costsLastYear[6]);
        request.setAttribute("caugLY", costsLastYear[7]);
        request.setAttribute("csepLY", costsLastYear[8]);
        request.setAttribute("coctLY", costsLastYear[9]);
        request.setAttribute("cnovLY", costsLastYear[10]);
        request.setAttribute("cdecLY", costsLastYear[11]);

        super.setView(request, DASHBOARD_VIEW);

        super.getView().forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

}
