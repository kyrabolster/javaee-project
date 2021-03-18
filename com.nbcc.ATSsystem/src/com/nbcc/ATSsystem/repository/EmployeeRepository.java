/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATSsystem.repository;

import com.nbcc.ATSsystem.models.EmployeeFactory;
import com.nbcc.ATSsystem.models.IEmployee;
import com.nbcc.dataaccess.DALFactory;
import com.nbcc.dataaccess.IDAL;
import com.nbcc.dataaccess.IParameter;
import com.nbcc.dataaccess.ParameterFactory;
import java.sql.SQLException;
import java.util.List;
import javax.sql.rowset.CachedRowSet;

/**
 *
 * @author KyraB
 */
public class EmployeeRepository extends BaseRepository implements IEmployeeRepository {

    private final String SPROC_SELECT_EMPLOYEES = "CALL RetrieveAllEmployees(null)";
    private final String SPROC_SELECT_EMPLOYEE = "CALL RetrieveAllEmployeeById(?)";
    private final String SPROC_INSERT_EMPLOYEE = "CALL InsertEmployee(?,?,?,?);";

    private IDAL dataAccess;

    public EmployeeRepository() {
        dataAccess = DALFactory.createInstance();
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
            CachedRowSet cr = dataAccess.executeFill(SPROC_SELECT_EMPLOYEES, params);
            employees = toListofEmployees(cr);
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
            employee.setHourlyRate(super.getDouble("HourlyRate", cs));
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
    public int updateEmployee(IEmployee employee) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int deleteEmployee(IEmployee employee) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}
