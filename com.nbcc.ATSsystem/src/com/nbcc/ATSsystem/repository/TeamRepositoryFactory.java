/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATSsystem.repository;

/**
 *
 * @author Soyoung Kim
 * @date 2021-03-20
 */
public class TeamRepositoryFactory {
    public static ITeamRepository createInstance() {
        return new TeamRepository();
    }
}
