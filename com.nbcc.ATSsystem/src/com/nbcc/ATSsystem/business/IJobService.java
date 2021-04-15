/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATSsystem.business;

import com.nbcc.ATSsystem.models.IJob;
import com.nbcc.ATSsystem.models.ITask;
import com.nbcc.ATSsystem.models.TeamListVM;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Soyoung Kim
 * @date 2021-04-01
 */
public interface IJobService {
    boolean isValid(IJob job);
    
    IJob createJob(IJob job);
    int saveJob(IJob job);
    int deleteJob(int id);
    
    IJob getJob(int id);
    List<IJob> getJobs();
    List<IJob> getJobsByDate(String date);
    List<IJob> getJobsByMonth(int month, int year);
    int getNumJobsToday();
    
    List<ITask> getTasks();
    List<TeamListVM> getAvailableTeams(String start, String tasks, boolean isOnSite);
    TeamListVM getTeamByJob(int jobId);
}
