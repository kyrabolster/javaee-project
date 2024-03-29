/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATSsystem.repository;

import com.nbcc.ATSsystem.models.EmployeeFactory;
import com.nbcc.ATSsystem.models.IEmployee;
import com.nbcc.ATSsystem.models.IJob;
import com.nbcc.ATSsystem.models.ITask;
import com.nbcc.ATSsystem.models.JobFactory;
import com.nbcc.ATSsystem.models.TaskFactory;
import com.nbcc.ATSsystem.models.TeamListVM;
import com.nbcc.dataaccess.DALFactory;
import com.nbcc.dataaccess.IDAL;
import com.nbcc.dataaccess.IParameter;
import com.nbcc.dataaccess.ParameterFactory;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.sql.rowset.CachedRowSet;

/**
 *
 * @author Soyoung Kim
 * @date 2021-03-30
 */
public class JobRepository extends BaseRepository implements IJobRepository {

    private final String SPROC_INSERT_JOB = "CALL InsertJob(?,?,?,?,?,?,?,?)";
    private final String SPROC_INSERT_EMERGENCYJOB = "CALL InsertEmergencyJob(?,?,?,?,?,?,?,?)";
    private final String SPROC_SELECT_TEAMS = "CALL SelectAvailableTeamList(?,?,?)";
    private final String SPROC_SELECT_EMERGENCYTEAM = "CALL SelectEmergencyTeam(?,?,?)";
    private final String SPROC_SELECT_JOB = "CALL SelectJobs(?,null)";
    private final String SPROC_SELECT_JOBS = "CALL SelectJobs(null, null)";
    private final String SPROC_SELECT_JOBSBYDATE = "CALL SelectJobs(null, ?)";
    private final String SPROC_SELECT_JOBSBYMONTH = "CALL SelectJobsByMonth(?,?)";
    private final String SPROC_SELECT_TASKS = "CALL RetrieveTasks(null)";
    private final String SPROC_SELECT_TEAMBYJOB = "CALL SelecTeamByJobTeamId(?)";
    private final String SPROC_DELETE_JOB = "CALL DeleteJob(?)";
    private final String SPROC_GET_NUM_JOBS = "CALL GetNumJobsForDay()";

    private IDAL dataAccess;

    public JobRepository() {
        dataAccess = DALFactory.createInstance();
    }

    /**
     * Insert Job
     *
     * @param job
     * @return id of inserted job
     */
    @Override
    public int insertJob(IJob job) {
        int returnId = 0;

        List<Object> returnValues;

        List<IParameter> params = ParameterFactory.createListInstance();

        params.add(ParameterFactory.createInstance(job.getTeamId()));
        params.add(ParameterFactory.createInstance(job.getClientName()));
        params.add(ParameterFactory.createInstance(job.getDescription()));
        params.add(ParameterFactory.createInstance(job.getStart()));
        params.add(ParameterFactory.createInstance(job.getSelectedTasks()));
        params.add(ParameterFactory.createInstance(job.getIsOnSite()));
        params.add(ParameterFactory.createInstance(job.getTotalDuration()));

        params.add(ParameterFactory.createInstance(returnId, IParameter.Direction.OUT, java.sql.Types.INTEGER));

        DateTimeFormatter format = DateTimeFormatter.ofPattern("HH:mm:ss");

        String before = "08:00:00";
        String after = "17:00:00";
        String target = job.getStart().toString().substring(11, 19);
        String targetDate = job.getStart().toString().substring(0, 11);
        Date date = new Date();

        try {
            date = new SimpleDateFormat("yyyy-MM-dd").parse(targetDate);
        } catch (ParseException ex) {
            Logger.getLogger(JobRepository.class.getName()).log(Level.SEVERE, null, ex);
        }

        LocalTime time = LocalTime.parse(target, format);
        LocalTime morning = LocalTime.parse(before, format);
        LocalTime night = LocalTime.parse(after, format);

        if (time.isBefore(morning) || time.isAfter(night) || date.getDay() == 0 || date.getDay() == 6) {
            returnValues = dataAccess.executeNonQuery(SPROC_INSERT_EMERGENCYJOB, params);

        } else {
            returnValues = dataAccess.executeNonQuery(SPROC_INSERT_JOB, params);
        }

        try {
            if (returnValues != null) {
                returnId = Integer.parseInt(returnValues.get(0).toString());
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return returnId;
    }

    /**
     * Delete job by id
     * @param id
     * @return number of rows affected
     */
    @Override
    public int deleteJob(int id) {
        int rowsAffedcted = 0;
        List<Object> returnValues;
        List<IParameter> params = ParameterFactory.createListInstance();

        params.add(ParameterFactory.createInstance(id));

        returnValues = dataAccess.executeNonQuery(SPROC_DELETE_JOB, params);

        try {
            if (returnValues != null) {
                rowsAffedcted = Integer.parseInt(returnValues.get(0).toString());
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return rowsAffedcted;
    }

    /**
     * Get all jobs
     * @return list of jobs
     */
    @Override
    public List<IJob> retrieveJobs() {
        List<IJob> retrievedJobs = JobFactory.createListInstance();

        try {
            CachedRowSet cr = dataAccess.executeFill(SPROC_SELECT_JOBS, null);
            retrievedJobs = toListofJobs(cr);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return retrievedJobs;
    }

    /**
     * Get job by id
     * @param id
     * @return job with respective id
     */
    @Override
    public IJob retrieveJob(int id) {
        List<IJob> jobs = JobFactory.createListInstance();

        try {
            List<IParameter> params = ParameterFactory.createListInstance();
            params.add(ParameterFactory.createInstance(id));

            CachedRowSet cr = dataAccess.executeFill(SPROC_SELECT_JOB, params);
            jobs = toListofJobs(cr);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return jobs.get(0);
    }

    /**
     * Get Jobs by date
     * @param date
     * @return list of jobs
     */
    @Override
    public List<IJob> retrieveJobsByDate(String date) {
        List<IJob> retrievedJobs = JobFactory.createListInstance();

        List<IParameter> params = ParameterFactory.createListInstance();
        params.add(ParameterFactory.createInstance(date));
        try {
            CachedRowSet cr = dataAccess.executeFill(SPROC_SELECT_JOBSBYDATE, params);
            retrievedJobs = toListofJobs(cr);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return retrievedJobs;

    }

    /**
     * Get jobs by month
     * @param month
     * @param year
     * @return list of jobs
     */
    @Override
    public List<IJob> retrieveJobsByMonth(int month, int year) {
        List<IJob> retrievedJobs = JobFactory.createListInstance();

        List<IParameter> params = ParameterFactory.createListInstance();
        params.add(ParameterFactory.createInstance(month));
        params.add(ParameterFactory.createInstance(year));
        try {
            CachedRowSet cr = dataAccess.executeFill(SPROC_SELECT_JOBSBYMONTH, params);
            retrievedJobs = toListofJobs(cr);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return retrievedJobs;
    }

    /**
     * Get jobs by year
     * @param year
     * @return list of jobs
     */
    @Override
    public List<IJob> retrieveJobsByYear(int year) {
        List<IJob> retrievedJobs = JobFactory.createListInstance();

        List<IParameter> params = ParameterFactory.createListInstance();
        params.add(ParameterFactory.createInstance(null));
        params.add(ParameterFactory.createInstance(year));

        try {
            CachedRowSet cr = dataAccess.executeFill(SPROC_SELECT_JOBSBYMONTH, params);
            retrievedJobs = toListofJobs(cr);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return retrievedJobs;
    }

    /**
     * Get number of jobs for current day
     * @return number of jobs for current day
     */
    @Override
    public int retrieveNumJobsToday() {
        int numJobs = 0;

        try {
            CachedRowSet cr = dataAccess.executeFill(SPROC_GET_NUM_JOBS, null);
            while (cr.next()) {
                numJobs = super.getInt("COUNT(Id)", cr);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return numJobs;
    }

    /**
     * Retrieve all tasks
     * @return list of tasks
     */
    @Override
    public List<ITask> retrieveTasks() {
        List<ITask> retrievedTasks = TaskFactory.createListInstance();

        try {
            CachedRowSet cr = dataAccess.executeFill(SPROC_SELECT_TASKS, null);
            retrievedTasks = toListofTasks(cr);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return retrievedTasks;
    }

    /**
     * Get list of tasks from row set
     * @param cs
     * @return list of tasks
     * @throws SQLException 
     */
    private List<ITask> toListofTasks(CachedRowSet cs) throws SQLException {
        List<ITask> retrievedTasks = TaskFactory.createListInstance();
        ITask task;

        while (cs.next()) {
            task = TaskFactory.createInstance();
            task.setId(super.getInt("id", cs));
            task.setName(cs.getString("Name"));
            retrievedTasks.add(task);
        }
        return retrievedTasks;
    }

    /**
     * Get available teams matching params
     * @param start
     * @param tasks
     * @param isOnSite
     * @return list of teams
     */
    @Override
    public List<TeamListVM> retrieveAvailableTeamList(String start, String tasks, boolean isOnSite) {
        List<TeamListVM> retrievedTeamList = new ArrayList<>();

        List<IParameter> params = ParameterFactory.createListInstance();

        params.add(ParameterFactory.createInstance(start));
        params.add(ParameterFactory.createInstance(tasks));
        params.add(ParameterFactory.createInstance(isOnSite));

        try {

            DateTimeFormatter format = DateTimeFormatter.ofPattern("HH:mm:ss");

            String before = "08:00:00";
            String after = "17:00:00";
            String targetTime = start.substring(11);
            String targetDate = start.substring(0, 11);
            Date date = new SimpleDateFormat("yyyy-MM-dd").parse(targetDate);

            LocalTime time = LocalTime.parse(targetTime, format);
            LocalTime morning = LocalTime.parse(before, format);
            LocalTime night = LocalTime.parse(after, format);

            CachedRowSet cr;

            if (time.isBefore(morning) || time.isAfter(night) || date.getDay() == 0 || date.getDay() == 6) {
                cr = dataAccess.executeFill(SPROC_SELECT_EMERGENCYTEAM, params);

            } else {
                cr = dataAccess.executeFill(SPROC_SELECT_TEAMS, params);
            }

            while (cr.next()) {
                TeamListVM team = new TeamListVM();
                team.setId(super.getInt("Teamid", cr));
                team.setTeamName(cr.getString("TeamName"));
                team.setTotalDuration(super.getInt("totalDuration", cr));
                team.setStart(cr.getTimestamp("StartDate"));
                team.setEnd(cr.getTimestamp("EndDate"));

                retrievedTeamList.add(team);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return retrievedTeamList;
    }

    /**
     * Get list of jobs from row set
     * @param cs
     * @return list of jobs
     * @throws SQLException 
     */
    private List<IJob> toListofJobs(CachedRowSet cs) throws SQLException {
        List<IJob> retrievedJobs = JobFactory.createListInstance();
        IJob job;

        while (cs.next()) {
            job = JobFactory.createInstance();
            job.setId(super.getInt("Id", cs));
            job.setTeamId(super.getInt("TeamId", cs));
            job.setTeamName(super.getString("TeamName", cs));
            job.setClientName(super.getString("ClientName", cs));
            job.setDescription(super.getString("Description", cs));
            job.setStart(cs.getTimestamp("Start"));
            job.setEnd(cs.getTimestamp("End"));
            job.setCost(super.getDouble("Cost", cs));
            job.setRevenue(super.getDouble("Revenue", cs));
            job.setTasksName(super.getString("tasks", cs));

            retrievedJobs.add(job);
        }

        return retrievedJobs;
    }

    /**
     * Get team list by job id
     * @param jobId
     * @return team view model matching job id
     */
    @Override
    public TeamListVM retrieveTeamListByJobId(int jobId) {
        TeamListVM team = new TeamListVM();

        List<IParameter> params = ParameterFactory.createListInstance();

        params.add(ParameterFactory.createInstance(jobId));

        try {
            CachedRowSet cr = dataAccess.executeFill(SPROC_SELECT_TEAMBYJOB, params);

            if (cr.next()) {
                team.setId(super.getInt("Id", cr));
                team.setTeamName(cr.getString("Name"));
            }

            List<IEmployee> retrievedEmployees = EmployeeFactory.createListInstance();
            IEmployee employee;

            cr = dataAccess.executeFill(SPROC_SELECT_TEAMBYJOB, params);

            while (cr.next()) {
                employee = EmployeeFactory.createInstance();
                employee.setId(super.getInt("employeeId", cr));
                employee.setFirstName(cr.getString("FirstName"));
                employee.setLastName(cr.getString("LastName"));

                retrievedEmployees.add(employee);
            }

            team.setTeamMembers(retrievedEmployees);

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return team;
    }

}
