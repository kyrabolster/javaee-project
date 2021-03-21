/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATSsystem.repository;

/**
 *
 * @author KyraB
 */
public abstract class EmployeeRepositoryFactory {
     public static IEmployeeRepository createInstance() {
        return new EmployeeRepository();
    }
}
