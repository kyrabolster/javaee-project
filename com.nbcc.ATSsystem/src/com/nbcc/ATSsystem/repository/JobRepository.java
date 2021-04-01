/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATSsystem.repository;

import com.nbcc.ATSsystem.models.IJob;
import com.nbcc.ATSsystem.models.ITask;
import com.nbcc.ATSsystem.models.TaskFactory;
import com.nbcc.dataaccess.DALFactory;
import com.nbcc.dataaccess.IDAL;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import javax.sql.rowset.CachedRowSet;

/**
 *
 * @author Soyoung Kim
 * @date 2021-03-30
 */
public class JobRepository extends BaseRepository implements IJobRepository{
    private final String SPROC_INSERT_JOB = "CALL InsertJob(?,?,?,?,?,?,?)";
    private final String SPROC_SELECT_TEAMS = "CALL SelectAvailableTeamList(?,?,?,?)";
    private final String SPROC_SELECT_EMERGENCY_TEAM = "CALL SelectEmergencyTeam(?,?,?,?)";
    private final String SPROC_SELECT_JOB = "CALL SelectJobs(?)";
    private final String SPROC_SELECT_JOBS = "CALL SelectJobs(null)";    
    private final String SPROC_SELECT_TASKS = "CALL SelectTasks(null)";
    
    private IDAL dataAccess;

    public JobRepository() {
        dataAccess = DALFactory.createInstance();
    }
    
    @Override
    public int insertJob(IJob job) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int updateJob(IJob job) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int deleteJob(IJob Job) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public List<IJob> retrieveJobs() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public IJob retrieveJob(int id) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
    @Override
    public List<IJob> retrieveJobsByDate(Date date) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.

    }
    
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
}
