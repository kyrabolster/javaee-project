/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATSsystem.repository;

import com.nbcc.ATSsystem.models.IJob;
import com.nbcc.ATSsystem.models.ITask;
import com.nbcc.ATSsystem.models.TeamListVM;
import java.util.List;

/**
 *
 * @author Soyoung Kim
 * @date 2021-03-30
 */
public interface IJobRepository {
    int insertJob(IJob job);
    
    int updateJob(IJob job);
    
    int deleteJob(int id);
    
    List<IJob> retrieveJobs();
    
    List<IJob> retrieveJobsByDate(String date);
    
    List<IJob> retrieveJobsByMonth(int month, int year);
    
    IJob retrieveJob(int id);
    
    List<ITask> retrieveTasks();
    
    List<TeamListVM> retrieveAvailableTeamList(String start, String tasks, boolean isOnSite);
    
    TeamListVM retrieveTeamListByJobId(int jobId);
    
    int retrieveNumJobsToday();
}
