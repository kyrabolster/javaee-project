/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATSsystem.business;

import com.nbcc.ATSsystem.models.ErrorFactory;
import com.nbcc.ATSsystem.models.ITask;
import com.nbcc.ATSsystem.repository.ITaskRepository;
import com.nbcc.ATSsystem.repository.TaskRepositoryFactory;
import java.util.List;

/**
 *
 * @author Soyoung Kim
 * @date 2021-03-16
 */
public class TaskService implements ITaskService {

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
    public List<ITask> getTasksNotAssignedToEmployee(int employeeId) {
        List<ITask> tasks = repo.retrieveTasksNotAssignedToEmployee(employeeId);
        return tasks;
    }

    @Override
    public boolean isValid(ITask task) {
        return task.getErrors().isEmpty();
    }

    @Override
    public ITask createTask(ITask task) {
        if (isValid(task)) {
            int id = repo.insertTask(task);
            if (id > 0) {
                task.setId(id);
            } else {
                task.addError(ErrorFactory.createInstance(5, "Task was not valid for creation. Database error."));
            }
        } else {
            task.addError(ErrorFactory.createInstance(5, "Task failed validation for creation"));
        }

        return task;
    }

    @Override
    public int saveTask(ITask task) {
        if(task.getId() == 0) {
            task.addError(ErrorFactory.createInstance(14, "Task was not saved. Id is required."));
        }
        
        if(isValid(task)){
            return repo.updateTask(task);
        } else {
            task.addError(ErrorFactory.createInstance(14, "Task invalid for saving"));
            return 0;
        }
    }

    @Override
    public int deleteTask(int id) {
        if (id == 0) {
            return 0;
        } else {
            return repo.deleteTask(id);
        }
    }

}
