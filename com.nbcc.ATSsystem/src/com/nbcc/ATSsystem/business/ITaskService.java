/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATSsystem.business;

import com.nbcc.ATSsystem.models.ITask;
import java.util.List;

/**
 *
 * @author Soyoung Kim
 * @date 2021-03-16
 */
public interface ITaskService {
    boolean isValid(ITask task);
    
    ITask createTask(ITask task);
    int saveTask(ITask task);
    int deleteTask(int id);
    
    ITask getTask(int id);
    List<ITask> getTasks();
    List<ITask> getTasksNotAssignedToEmployee(int employeeId);
}
