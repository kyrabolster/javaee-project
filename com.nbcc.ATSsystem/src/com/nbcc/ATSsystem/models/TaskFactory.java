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
 * @date 2021-03-15
 */
public abstract class TaskFactory {
    public static ITask createInstance() {
        return new Task();
    }
    
    public static ArrayList<ITask> createListInstance() {
        return new ArrayList();
    }
}
