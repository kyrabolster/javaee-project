/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATS.controllers;

import com.nbcc.ATS.models.ErrorViewModel;
import com.nbcc.ATS.models.JobDeletedViewModel;
import com.nbcc.ATSsystem.business.IJobService;
import com.nbcc.ATSsystem.business.JobServiceFactory;
import com.nbcc.ATSsystem.models.ErrorFactory;
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
    private static final String TASK_ERROR = "/error.jsp";

    //common variables for creating job
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

            if (jobExists(id)) {
                IJob job = jobService.getJob(id);

                if (job != null) {
                    request.setAttribute("job", job);
                    request.setAttribute("team", jobService.getTeamByJob(id));
                } else {
                    request.setAttribute("error", new ErrorViewModel(String.format("Job ID: $s is not found", id)));
                }
                super.setView(request, JOBS_MAINT_VIEW);

            } else {
                request.setAttribute("entity", "job");
                super.setView(request, TASK_ERROR);
            }

            List<ITask> tasks = jobService.getTasks();
            request.setAttribute("tasks", tasks);

            super.setView(request, JOBS_MAINT_VIEW);
        } else {
            request.setAttribute("jobs", jobService.getJobs());
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
                case "search team":
                    super.setView(request, JOBS_MAINT_VIEW);

                    taskIds.clear();
                    teamList.clear();
                    selectedTasks = "";

                    job = setTempJob(request);
                    request.setAttribute("job", job);

                    selectedTasks = String.join(",", request.getParameterValues("task"));
                    Date start = super.getDateTime(request, "jobStart");

                    DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                    String jobStart = df.format(start);

                    boolean isOnSite = request.getParameter("isOnSite") != null;

                    if (job.getErrors().isEmpty()) {
                        teamList = jobService.getAvailableTeams(jobStart, selectedTasks, isOnSite);
                        request.setAttribute("teams", teamList);
                    }

                    break;

                case "reset":
                    request.setAttribute("team", null);
                    break;

                case "create":
                    super.setView(request, JOB_SUMMARY_VIEW);

                    job = setJob(request);
                    request.setAttribute("job", job);
                    job = jobService.createJob(job);

                    request.setAttribute("job", jobService.getJob(job.getId()));
                    request.setAttribute("team", selectedTeam.get(0));
                    request.setAttribute("tasks", taskNames);

                    if (!jobService.isValid(job)) {
                        request.setAttribute("error", job.getErrors());
                        request.setAttribute("teams", teamList);
                        super.setView(request, JOBS_MAINT_VIEW);
                    }

                    break;

                case "delete":
                    super.setView(request, JOB_SUMMARY_VIEW);

                    job = jobService.getJob(id);
                    request.setAttribute("job", job);
                    request.setAttribute("team", jobService.getTeamByJob(id));

                    int rowsAffected = jobService.deleteJob(id);

                    if (rowsAffected == 0) {
                        job.addError(ErrorFactory.createInstance(13, "No record affected. Delete was unsuccessful"));
                        request.setAttribute("errors", job.getErrors());
                        super.setView(request, JOBS_MAINT_VIEW);
                    } else {
                        JobDeletedViewModel vm = new JobDeletedViewModel(id, rowsAffected);
                        request.setAttribute("deleteMessage", "The following job has been successfully deleted from the database.");
                        request.setAttribute("vm", vm);
                    }

                    break;

                case "search":
                    Date searchDate = super.getDate(request, "searchDate");
                    if (searchDate != null) {
                        DateFormat df2 = new SimpleDateFormat("yyyy-MM-dd");
                        String strDate = df2.format(searchDate);

                        request.setAttribute("jobs", jobService.getJobsByDate(strDate));
                    } else {
                        request.setAttribute("jobs", jobService.getJobs());
                    }
                    super.setView(request, JOBS_VIEW);
                    break;
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
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
        Timestamp start = null;
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

        if (super.getDateTime(request, "jobStart") != null) {
            start = new Timestamp(super.getDateTime(request, "jobStart").getTime());
        }

        if (request.getParameter("isOnSite") == null || "".equals(request.getParameter("isOnSite"))) {
            isOnSite = false;
        } else {
            isOnSite = true;
        }

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

    private boolean jobExists(int id) {
        IJobService jobService = JobServiceFactory.createInstance();

        List<IJob> jobs = jobService.getJobs();

        List<Integer> jobIds = new ArrayList<>();

        for (IJob job : jobs) {
            int jobId = job.getId();
            jobIds.add(jobId);
        }

        return jobIds.contains(id);
    }

}
