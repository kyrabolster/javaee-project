/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATS.controllers;

import com.nbcc.ATS.models.ErrorViewModel;
import com.nbcc.ATSsystem.business.IJobService;
import com.nbcc.ATSsystem.business.JobServiceFactory;
import com.nbcc.ATSsystem.models.IJob;
import com.nbcc.ATSsystem.models.ITask;
import com.nbcc.ATSsystem.models.JobFactory;
import com.nbcc.ATSsystem.models.TeamListVM;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author notil
 */
public class JobController extends CommonController {

    private static final String JOBS_VIEW = "/jobs.jsp";
    private static final String JOBS_MAINT_VIEW = "/job.jsp";
    private static final String JOB_SUMMARY_VIEW = "/jobsummary.jsp";
    private List<String> taskIds = new ArrayList<>();
    private List<TeamListVM> teamList = new ArrayList<>();
    private List<TeamListVM> selectedTeam = new ArrayList<>();
    private List<String> taskNames = new ArrayList<>();
    private String selectedTasks;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        IJobService jobService = JobServiceFactory.createInstance();

        if (pathInfo != null) {
            String[] pathParts = pathInfo.split("/");
            int id = super.getInteger(pathParts[1]);

            if (id > 0) {
                // getjob(int id) -> job/{id}
            }

            List<ITask> tasks = jobService.getTasks();
            request.setAttribute("tasks", tasks);

            super.setView(request, JOBS_MAINT_VIEW);
        } else {
            super.setView(request, JOBS_VIEW);
        }

        super.getView().forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        IJobService jobService = JobServiceFactory.createInstance();
        IJob job;

        try {
            String action = super.getValue(request, "action");
            int id = super.getInteger(request, "hdnJobId");

            List<ITask> tasks = jobService.getTasks();
            request.setAttribute("tasks", tasks);

            switch (action.toLowerCase()) {
                case "searchteam":
                    super.setView(request, JOBS_MAINT_VIEW);

                    taskIds.clear();
                    teamList.clear();
                    selectedTasks = "";

                    job = setTempJob(request);
                    request.setAttribute("job", job);

                    selectedTasks = String.join(",", request.getParameterValues("task"));
                    Date start = super.getDate(request, "jobStart");
                    DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                    String jobStart = df.format(start);
                    
                    boolean isOnSite = request.getParameter("isOnSite") != null;

                    teamList = jobService.getAvailableTeams(jobStart, selectedTasks, isOnSite);

                    request.setAttribute("teams", teamList);
                    break;

                case "reset":
                    request.setAttribute("team", null);
                    break;

                case "create":
                    super.setView(request, JOB_SUMMARY_VIEW);

                    job = setJob(request);
                    request.setAttribute("job", job);
                    job = jobService.createJob(job);

                    request.setAttribute("job", job);
                    request.setAttribute("team", selectedTeam.get(0));
                    request.setAttribute("tasks", taskNames);

                    if (!jobService.isValid(job)) {
                        request.setAttribute("error", job.getErrors());
                        request.setAttribute("teams", teamList);
                        super.setView(request, JOBS_MAINT_VIEW);
                    }

                    break;
            }
        } catch (Exception e) {
            request.setAttribute("error", new ErrorViewModel("An error occurred attempting to maintain jobs"));
            List<ITask> tasks = jobService.getTasks();
            request.setAttribute("tasks", tasks);
            super.setView(request, JOBS_MAINT_VIEW);
        }

        super.getView().forward(request, response);
    }

    private IJob setTempJob(HttpServletRequest request) throws ParseException {
        String clientName;
        String description;
        Timestamp start;
        boolean isOnSite;

        taskNames.clear();

        if (request.getParameterValues("task") != null) {
            taskIds = new ArrayList<>(Arrays.asList(request.getParameterValues("task")));
        }

        IJobService jobService = JobServiceFactory.createInstance();
        List<ITask> tasks = jobService.getTasks();
        List<ITask> selectedTasks = new ArrayList<>();

        for (String id : taskIds) {
            selectedTasks = tasks.stream().filter(t -> t.getId() == Integer.parseInt(id)).collect(Collectors.toList());
            taskNames.add(selectedTasks.get(0).getName());
        }

        clientName = super.getValue(request, "clientName");
        description = super.getValue(request, "jobDescription");
        start = new Timestamp(super.getDate(request, "jobStart").getTime());
        
        isOnSite = request.getParameter("isOnSite") != null;

        IJob job = JobFactory.createInstance(clientName, description, start, taskNames, isOnSite);

        return job;
    }

    private IJob setJob(HttpServletRequest request) throws ParseException {
        IJob tempJob = setTempJob(request);
        int teamId;
        int totalDuration;

        selectedTeam = new ArrayList<>();
        teamId = super.getInteger(request, "isSelecteTeam");
        selectedTeam = teamList.stream().filter(t -> t.getId() == teamId).collect(Collectors.toList());
        totalDuration = selectedTeam.get(0).getTotalDuration();

        IJob job = JobFactory.createInstance(teamId, tempJob.getClientName(), tempJob.getDescription(), tempJob.getStart(), taskIds, tempJob.getIsOnSite(), totalDuration, selectedTasks);

        return job;
    }

}
