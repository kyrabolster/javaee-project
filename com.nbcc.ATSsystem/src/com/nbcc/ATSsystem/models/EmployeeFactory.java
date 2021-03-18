/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATSsystem.models;

import java.util.ArrayList;

/**
 *
 * @author KyraB
 */
public abstract class EmployeeFactory {
     public static IEmployee createInstance() {
        return new Employee();
    }
    
    public static IEmployee createInstance(String firstName, String lastName, String SIN, double hourlyRate) {
        return new Employee(firstName, lastName, SIN, hourlyRate);
    }
    
    public static ArrayList<IEmployee> createListInstance() {
        return new ArrayList();
    }
    
}
