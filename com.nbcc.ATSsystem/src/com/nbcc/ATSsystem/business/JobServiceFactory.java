/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATSsystem.business;

/**
 *
 * @author Soyoung Kim
 * @date 2021-04-01
 */
public class JobServiceFactory {

    public static IJobService createInstance() {
        return new JobService();
    }
}
