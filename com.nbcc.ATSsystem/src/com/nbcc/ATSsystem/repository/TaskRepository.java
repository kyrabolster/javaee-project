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
    public ITask retrieveTask(int id) {
        List<ITask> tasks = TaskFactory.createListInstance();

        try {
            List<IParameter> params = ParameterFactory.createListInstance();
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
            retrievedTasks.add(task);
        }
        
        return retrievedTasks;
    }
}
