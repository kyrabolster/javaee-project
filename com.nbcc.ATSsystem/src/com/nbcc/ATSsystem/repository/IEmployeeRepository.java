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
    int deleteEmployee(IEmployee employee);
    List<IEmployee> retrieveEmployees();
    IEmployee retrieveEmployee(int id);
}
