/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATSsystem.models;

/**
 *
 * @author Soyoung Kim
 * @date 2021-03-20
 */
public class EmployeeVM {
    private int id;
    private String name;

    public EmployeeVM() {
        id = 0;
        name = "";
    }
    
    public EmployeeVM(int id, String name) {
        setId(id);
        setName(name);
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
    
}
