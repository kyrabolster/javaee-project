/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATSsystem.business;

import com.nbcc.ATSsystem.models.ErrorFactory;
import com.nbcc.ATSsystem.models.IEmployee;
import com.nbcc.ATSsystem.repository.EmployeeRepositoryFactory;
import com.nbcc.ATSsystem.repository.IEmployeeRepository;
import java.util.List;

/**
 *
 * @author KyraB
 */
public class EmployeeService implements IEmployeeService {

    private final IEmployeeRepository repo;

    public EmployeeService() {
        repo = EmployeeRepositoryFactory.createInstance();
    }

    @Override
    public IEmployee getEmployee(int id) {
        IEmployee employee = repo.retrieveEmployee(id);
        return employee;
    }

    @Override
    public List<IEmployee> getEmployees() {
        List<IEmployee> employees = repo.retrieveEmployees();
        return employees;
    }
    
    @Override
    public List<IEmployee> getEmployees(String search) {
        List<IEmployee> employees = repo.retrieveEmployees(search);
        return employees;
    }

    @Override
    public boolean isValid(IEmployee employee) {
        return employee.getErrors().isEmpty();
    }

    @Override
    public IEmployee createEmployee(IEmployee employee) {
        if (isValid(employee)) {
            int id = repo.insertEmployee(employee);
            if (id > 0) {
                employee.setId(id);
            } else {
                employee.addError(ErrorFactory.createInstance(5, "Employee was not valid for creation. Database error."));
            }
        } else {
            employee.addError(ErrorFactory.createInstance(5, "Employee failed validation for creation"));
        }

        return employee;
    }

    @Override
    public boolean addEmployeeSkill(int EmployeeId, int TaskId) {
        return repo.addEmployeeSkill(EmployeeId, TaskId);
    }

    @Override
    public boolean removeEmployeeSkill(int EmployeeId, int TaskId) {
        return repo.removeEmployeeSkill(EmployeeId, TaskId);
    }

    @Override
    public int saveEmployee(IEmployee employee) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int deleteEmployee(int id) {
        if (id == 0) {
            return 0;
        } else {
            return repo.deleteEmployee(id);
        }
    }
}
