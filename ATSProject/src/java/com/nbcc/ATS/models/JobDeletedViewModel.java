/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATS.models;

import java.io.Serializable;

/**
 *
 * @author Soyoung Kim
 * @date 2021-04-03
 */
public class JobDeletedViewModel implements Serializable {
    private int id;
    private int rowsDeleted;
    
    public JobDeletedViewModel(){}

    public JobDeletedViewModel(int id, int rowsDeleted) {
        this.id = id;
        this.rowsDeleted = rowsDeleted;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getRowsDeleted() {
        return rowsDeleted;
    }

    public void setRowsDeleted(int rowsDeleted) {
        this.rowsDeleted = rowsDeleted;
    }
}