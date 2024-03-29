/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATSsystem.business;

import com.nbcc.ATSsystem.models.IEmployee;
import java.util.List;

/**
 *
 * @author KyraB
 */
public interface IEmployeeService {

    boolean isValid(IEmployee employee);

    IEmployee createEmployee(IEmployee employee);

    int saveEmployee(IEmployee employee);

    int deleteEmployee(int id);

    IEmployee getEmployee(int id);

    List<IEmployee> getEmployees();
    
    List<IEmployee> getEmployees(String search);

    boolean addEmployeeSkill(int EmployeeId, int TaskId);

    boolean removeEmployeeSkill(int EmployeeId, int TaskId);

}
