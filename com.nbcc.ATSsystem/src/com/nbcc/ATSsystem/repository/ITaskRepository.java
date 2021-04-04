/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATSsystem.repository;

import com.nbcc.ATSsystem.models.ITask;
import java.util.List;

/**
 *
 * @author Soyoung Kim
 * @date 2021-03-15
 */
public interface ITaskRepository {
    int insertTask(ITask task);
    int updateTask(ITask task);
    int deleteTask(int id);
    List<ITask> retrieveTasks();
    ITask retrieveTask(int id);
    List<ITask> retrieveTasksNotAssignedToEmployee(int employeeId);
}
