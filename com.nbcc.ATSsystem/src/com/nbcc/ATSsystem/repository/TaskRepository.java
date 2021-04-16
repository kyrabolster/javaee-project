/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATSsystem.repository;

import com.nbcc.ATSsystem.models.ITask;
import com.nbcc.ATSsystem.models.TaskFactory;
import com.nbcc.dataaccess.DALFactory;
import com.nbcc.dataaccess.IDAL;
import com.nbcc.dataaccess.IParameter;
import com.nbcc.dataaccess.ParameterFactory;
import java.sql.SQLException;
import java.util.List;
import javax.sql.rowset.CachedRowSet;

/**
 *
 * @author Soyoung Kim
 * @date 2021-03-15
 */
public class TaskRepository extends BaseRepository implements ITaskRepository {

    private final String SPROC_SELECT_TASKS = "CALL RetrieveTasks(null)";
    private final String SPROC_SELECT_TASK = "CALL RetrieveTasks(?)";
    private final String SPROC_INSERT_TASK = "CALL InsertTask(?,?,?,?);";
    private final String SPROC_TASKS_NOT_ASSIGNED_TO_EMP = "CALL GetTasksNotAssignedToEmployee(?);";
    private final String SPROC_UPDATE_TASK = "CALL UpdateTask(?,?,?,?)";
    private final String SPROC_DELETE_TASK = "CALL DeleteTask(?);";

    private IDAL dataAccess;

    public TaskRepository() {
        dataAccess = DALFactory.createInstance();
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

    @Override
    public List<ITask> retrieveTasksNotAssignedToEmployee(int employeeId) {
        List<ITask> retrievedTasks = TaskFactory.createListInstance();

        try {
            List<IParameter> params = ParameterFactory.createListInstance();
            params.add(ParameterFactory.createInstance(employeeId));
            CachedRowSet cr = dataAccess.executeFill(SPROC_TASKS_NOT_ASSIGNED_TO_EMP, params);
            retrievedTasks = toListofTasks(cr);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return retrievedTasks;
    }

    @Override
    public ITask retrieveTask(int id) {
        List<ITask> tasks = TaskFactory.createListInstance();

        try {
            List<IParameter> params = ParameterFactory.createListInstance();
            params.add(ParameterFactory.createInstance(id));
            CachedRowSet cr = dataAccess.executeFill(SPROC_SELECT_TASK, params);
            tasks = toListofTasks(cr);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return tasks.get(0);
    }

    private List<ITask> toListofTasks(CachedRowSet cs) throws SQLException {
        List<ITask> retrievedTasks = TaskFactory.createListInstance();
        ITask task;

        while (cs.next()) {
            task = TaskFactory.createInstance();
            task.setId(super.getInt("id", cs));
            task.setName(cs.getString("Name"));
            task.setDescription(cs.getString("Description"));
            task.setDuration(super.getInt("Duration", cs));
            task.setUpdatedAt(super.getDate("UpdatedAt", cs));
            retrievedTasks.add(task);
        }

        return retrievedTasks;
    }

    @Override
    public int insertTask(ITask task) {
        int returnId = 0;

        List<Object> returnValues;

        List<IParameter> params = ParameterFactory.createListInstance();

        params.add(ParameterFactory.createInstance(task.getName()));
        params.add(ParameterFactory.createInstance(task.getDescription()));
        params.add(ParameterFactory.createInstance(task.getDuration()));

        params.add(ParameterFactory.createInstance(returnId, IParameter.Direction.OUT, java.sql.Types.INTEGER));

        returnValues = dataAccess.executeNonQuery(SPROC_INSERT_TASK, params);

        try {
            if (returnValues != null) {
                returnId = Integer.parseInt(returnValues.get(0).toString());
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return returnId;
    }

    @Override
    public int updateTask(ITask task) {
        int rowsAffedcted = 0;
        List<Object> returnValues;
        
        List<IParameter> params = ParameterFactory.createListInstance();
        
        params.add(ParameterFactory.createInstance(task.getId()));
        params.add(ParameterFactory.createInstance(task.getName()));
        params.add(ParameterFactory.createInstance(task.getDescription()));
        params.add(ParameterFactory.createInstance(task.getDuration()));
        
        returnValues = dataAccess.executeNonQuery(SPROC_UPDATE_TASK, params);
        
        try {
            if(returnValues != null) {
                rowsAffedcted = Integer.parseInt(returnValues.get(0).toString());
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
                
        return rowsAffedcted;
    }

    @Override
    public int deleteTask(int id) {
        int rowsAffected = 0;
        List<Object> returnValues;
        List<IParameter> params = ParameterFactory.createListInstance();

        params.add(ParameterFactory.createInstance(id));

        returnValues = dataAccess.executeNonQuery(SPROC_DELETE_TASK, params);

        try {
            if (returnValues != null) {
                rowsAffected = Integer.parseInt(returnValues.get(0).toString());
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return rowsAffected;
    }
}
