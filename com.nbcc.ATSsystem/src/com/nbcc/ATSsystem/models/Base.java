/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATSsystem.models;

import java.util.ArrayList;

/**
 *
 * @author Soyoung Kim
 * @date 2021-03-12
 */
public abstract class Base implements IBase{
    private ArrayList<IError> errors = ErrorFactory.createListInstance();
    
    public ArrayList<IError> getErrors() {
        return errors;
    }
    
    public void addError(IError error){
        errors.add(error);        
    }
}
