/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATSsystem.repository;

import com.nbcc.ATSsystem.models.IEmployee;
import java.util.List;

/**
 *
 * @author KyraB
 */
public interface IEmployeeRepository {

    int insertEmployee(IEmployee employee);

    int updateEmployee(IEmployee employee);

    int deleteEmployee(int id);

    List<IEmployee> retrieveEmployees();
    
    List<IEmployee> retrieveEmployees(String search);

    IEmployee retrieveEmployee(int id);

    boolean addEmployeeSkill(int EmployeeId, int TaskId);

    boolean removeEmployeeSkill(int EmployeeId, int TaskId);

}
