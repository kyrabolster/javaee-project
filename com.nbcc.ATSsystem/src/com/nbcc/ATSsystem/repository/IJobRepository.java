/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATSsystem.repository;

import com.nbcc.ATSsystem.models.IJob;
import com.nbcc.ATSsystem.models.ITask;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Soyoung Kim
 * @date 2021-03-30
 */
public interface IJobRepository {
    int insertJob(IJob job);
    
    int updateJob(IJob job);
    
    int deleteJob(IJob Job);
    
    List<IJob> retrieveJobs();
    
    List<IJob> retrieveJobsByDate(Date date);
    
    IJob retrieveJob(int id);
    
    List<ITask> retrieveTasks();
}
