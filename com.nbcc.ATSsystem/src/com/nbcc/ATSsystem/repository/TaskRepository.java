/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATSsystem.repository;

import com.nbcc.ATSsystem.models.ITask;
import com.nbcc.dataaccess.DALFactory;
import com.nbcc.dataaccess.IDAL;
import java.util.List;

/**
 *
 * @author Soyoung Kim
 * @date 2021-03-15
 */
public class TaskRepository  extends BaseRepository implements ITaskRepository{
    private final String SPROC_SELECT_TASKS = "CALL RetrieveAllTasks";
    private final String SPROC_SELECT_TASK = "CALL RetrieveTasks(?)";
    
    private IDAL dataAccess;
    
    public TaskRepository() {
        dataAccess = DALFactory.createInstance();
    }

    @Override
    public int insertTask(ITask task) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int updateTask(ITask task) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int deleteTask(ITask task) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public List<ITask> retrieveTasks() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ITask retrieveTask(int id) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}
