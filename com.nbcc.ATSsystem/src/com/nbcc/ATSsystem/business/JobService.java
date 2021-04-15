/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATSsystem.business;

import com.nbcc.ATSsystem.models.ErrorFactory;
import com.nbcc.ATSsystem.models.IJob;
import com.nbcc.ATSsystem.models.ITask;
import com.nbcc.ATSsystem.models.TeamListVM;
import com.nbcc.ATSsystem.repository.IJobRepository;
import com.nbcc.ATSsystem.repository.JobRepositoryFactory;
import java.util.List;

/**
 *
 * @author Soyoung Kim
 * @date 2021-04-01
 */
public class JobService implements IJobService{
    private final IJobRepository repo;
    
    public JobService(){
        repo = JobRepositoryFactory.createInstance();
    }

    @Override
    public boolean isValid(IJob job) {
        return job.getErrors().isEmpty();
    }

    @Override
    public IJob createJob(IJob job) {
        if(isValid(job)){
            int id = repo.insertJob(job);
            if(id > 0) {
                job.setId(id);
            } else {
                job.addError(ErrorFactory.createInstance(7, "Job was not valid for creation. Database error."));
            }
        } else {
            job.addError(ErrorFactory.createInstance(7, "Job failed validation for creation."));
        }
        
        return job;
    }

    @Override
    public int saveJob(IJob job) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int deleteJob(int id) {
        return repo.deleteJob(id);
    }

    @Override
    public IJob getJob(int id) {
        return repo.retrieveJob(id);
    }

    @Override
    public List<IJob> getJobs() {
        return repo.retrieveJobs();
    }

    @Override
    public List<IJob> getJobsByDate(String date) {
        return repo.retrieveJobsByDate(date);
    }
    
    @Override
    public List<IJob> getJobsByMonth(int month, int year) {
        return repo.retrieveJobsByMonth(month, year);
    }


    @Override
    public List<ITask> getTasks() {
        return repo.retrieveTasks();
    }

    @Override
    public List<TeamListVM> getAvailableTeams(String start, String tasks, boolean isOnSite) {
        return repo.retrieveAvailableTeamList(start, tasks, isOnSite);
    }

    @Override
    public TeamListVM getTeamByJob(int jobId) {
        return repo.retrieveTeamListByJobId(jobId);
    }
    
    public int getNumJobsToday() {
        return repo.retrieveNumJobsToday();
    }
}
