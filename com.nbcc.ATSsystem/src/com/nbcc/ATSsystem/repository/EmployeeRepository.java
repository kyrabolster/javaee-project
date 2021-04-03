/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATSsystem.repository;

import com.nbcc.ATSsystem.models.EmployeeFactory;
import com.nbcc.ATSsystem.models.IEmployee;
import com.nbcc.ATSsystem.models.ITask;
import com.nbcc.ATSsystem.models.Task;
import com.nbcc.ATSsystem.models.TaskFactory;
import com.nbcc.dataaccess.DALFactory;
import com.nbcc.dataaccess.IDAL;
import com.nbcc.dataaccess.IParameter;
import com.nbcc.dataaccess.ParameterFactory;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.sql.rowset.CachedRowSet;

/**
 *
 * @author KyraB
 */
public class EmployeeRepository extends BaseRepository implements IEmployeeRepository {

    private final String SPROC_SELECT_EMPLOYEES = "CALL SelectEmployees(null)";
    private final String SPROC_SELECT_EMPLOYEE = "CALL SelectEmployees(?)";
    private final String SPROC_INSERT_EMPLOYEE = "CALL InsertEmployee(?,?,?,?,?);";
    private final String SPROC_SELECT_TASKS = "CALL SelectTasks(?)";
    private final String SPROC_SELECT_TEAMS = "CALL SelectTeams(?)";
    private final String SPROC_ADD_EMPLOYEE_SKILLS = "CALL AddEmployeeSkill(?,?)";
    private final String SPROC_REMOVE_EMPLOYEE_SKILLS = "CALL RemoveEmployeeSkill(?,?)";
    private final String SPROC_DELETE_EMPLOYEE = "CALL DeleteEmployee(?);";

    private IDAL dataAccess;

    public EmployeeRepository() {
        dataAccess = DALFactory.createInstance();
    }

    public List<ITask> retrieveTasks(int id) {
        List<ITask> tasks = new ArrayList();

        try {
            List<IParameter> params = ParameterFactory.createListInstance();
            params.add(ParameterFactory.createInstance(id));
            CachedRowSet cr = dataAccess.executeFill(SPROC_SELECT_TASKS, params);
            tasks = toListofTasks(cr);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return tasks;
    }

    private List<ITask> toListofTasks(CachedRowSet cs) throws SQLException {
        List<ITask> tasks = new ArrayList();

        while (cs.next()) {

            ITask task = TaskFactory.createInstance();

            task.setId(super.getInt("Id", cs));
            task.setName(super.getString("Name", cs));

            tasks.add(task);
        }
        return tasks;
    }

    public List<String> retrieveTeams(int id) {
        List<String> teams = new ArrayList();

        try {
            List<IParameter> params = ParameterFactory.createListInstance();
            params.add(ParameterFactory.createInstance(id));
            CachedRowSet cr = dataAccess.executeFill(SPROC_SELECT_TEAMS, params);
            teams = toListofTeams(cr);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return teams;
    }

    private List<String> toListofTeams(CachedRowSet cs) throws SQLException {
        List<String> teams = new ArrayList();

        while (cs.next()) {

            teams.add(super.getString("Name", cs));
        }
        return teams;
    }

    @Override
    public List<IEmployee> retrieveEmployees() {
        List<IEmployee> retrievedEmployees = EmployeeFactory.createListInstance();

        try {
            CachedRowSet cr = dataAccess.executeFill(SPROC_SELECT_EMPLOYEES, null);
            retrievedEmployees = toListofEmployees(cr);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return retrievedEmployees;
    }

    @Override
    public IEmployee retrieveEmployee(int id) {
        List<IEmployee> employees = EmployeeFactory.createListInstance();

        try {
            List<IParameter> params = ParameterFactory.createListInstance();
            params.add(ParameterFactory.createInstance(id));
            CachedRowSet cr = dataAccess.executeFill(SPROC_SELECT_EMPLOYEE, params);
            employees = toListofEmployees(cr);

            employees.get(0).setTasks(retrieveTasks(id));
            employees.get(0).setTeams(retrieveTeams(id));

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return employees.get(0);
    }

    private List<IEmployee> toListofEmployees(CachedRowSet cs) throws SQLException {
        List<IEmployee> retrievedEmployees = EmployeeFactory.createListInstance();
        IEmployee employee;

        while (cs.next()) {
            employee = EmployeeFactory.createInstance();
            employee.setId(super.getInt("id", cs));
            employee.setFirstName(cs.getString("FirstName"));
            employee.setLastName(cs.getString("LastName"));
            employee.setSIN(cs.getString("SIN"));
            employee.setHourlyRate(cs.getDouble("HourlyRate"));
            employee.setCreatedAt(super.getDate("CreatedAt", cs));
            employee.setIsDeleted(super.getBoolean("isDeleted", cs));
            employee.setDeletedAt(super.getDate("DeletedAt", cs));
            employee.setUpdatedAt(super.getDate("UpdatedAt", cs));

            retrievedEmployees.add(employee);
        }

        return retrievedEmployees;
    }

    @Override
    public int insertEmployee(IEmployee employee) {
        int returnId = 0;

        List<Object> returnValues;

        List<IParameter> params = ParameterFactory.createListInstance();

        params.add(ParameterFactory.createInstance(employee.getFirstName()));
        params.add(ParameterFactory.createInstance(employee.getLastName()));
        params.add(ParameterFactory.createInstance(employee.getSIN()));
        params.add(ParameterFactory.createInstance(employee.getHourlyRate()));

        params.add(ParameterFactory.createInstance(returnId, IParameter.Direction.OUT, java.sql.Types.INTEGER));

        returnValues = dataAccess.executeNonQuery(SPROC_INSERT_EMPLOYEE, params);

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
    public boolean addEmployeeSkill(int EmployeeId, int TaskId) {

        List<Object> returnValues = null;

        List<IParameter> params = ParameterFactory.createListInstance();

        params.add(ParameterFactory.createInstance(EmployeeId));
        params.add(ParameterFactory.createInstance(TaskId));

        try {
            returnValues = dataAccess.executeNonQuery(SPROC_ADD_EMPLOYEE_SKILLS, params);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return returnValues != null;
    }

    @Override
    public boolean removeEmployeeSkill(int EmployeeId, int TaskId) {

        List<Object> returnValues = null;

        List<IParameter> params = ParameterFactory.createListInstance();

        params.add(ParameterFactory.createInstance(EmployeeId));
        params.add(ParameterFactory.createInstance(TaskId));

        try {
            returnValues = dataAccess.executeNonQuery(SPROC_REMOVE_EMPLOYEE_SKILLS, params);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return returnValues != null;
    }

    @Override
    public int updateEmployee(IEmployee employee) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int deleteEmployee(int id) {
        int rowsAffected = 0;
        List<Object> returnValues;
        List<IParameter> params = ParameterFactory.createListInstance();

        params.add(ParameterFactory.createInstance(id));

        returnValues = dataAccess.executeNonQuery(SPROC_DELETE_EMPLOYEE, params);

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
