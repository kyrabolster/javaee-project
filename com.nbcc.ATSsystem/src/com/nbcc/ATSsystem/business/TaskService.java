/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATSsystem.business;

import com.nbcc.ATSsystem.models.ITask;
import com.nbcc.ATSsystem.repository.ITaskRepository;
import com.nbcc.ATSsystem.repository.TaskRepositoryFactory;
import java.util.List;

/**
 *
 * @author Soyoung Kim
 * @date 2021-03-16
 */
public class TaskService implements ITaskService{
    private final ITaskRepository repo;
    
    public TaskService() {
        repo = TaskRepositoryFactory.createInstance();
    }

    
    @Override
    public ITask getTask(int id) {
        ITask task = repo.retrieveTask(id);
        return task;
    }

    @Override
    public List<ITask> getTasks() {
        List<ITask> tasks = repo.retrieveTasks();
        return tasks;
    }
    
    @Override
    public boolean isValid(ITask task) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ITask createTask(ITask task) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int saveTask(ITask task) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int deleteTask(int id) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    
    
}
