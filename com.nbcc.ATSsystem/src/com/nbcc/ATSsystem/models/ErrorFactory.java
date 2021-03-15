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
 * @date 2021-03-10
 */
public abstract class ErrorFactory {
    //Complete the factory for constructors
    //Create List Instance
    
    public static IError createInstance(int code, String description) {
        return new Error(code, description);
    }
    
    public static ArrayList<IError> createListInstance() {
        return new ArrayList();
    }
    
}
