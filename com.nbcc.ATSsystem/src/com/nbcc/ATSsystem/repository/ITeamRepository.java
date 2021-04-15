/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATSsystem.repository;

import com.nbcc.ATSsystem.models.EmployeeVM;
import com.nbcc.ATSsystem.models.ITeam;
import java.util.List;

/**
 *
 * @author Soyoung Kim
 * @date 2021-03-20
 */
public interface ITeamRepository {
    int insertTeam(ITeam team);
    int updateTeam(ITeam team);
    int deleteTeam(int id);
    List<ITeam> retrieveTeams();
    ITeam retrieveTeam(int id);
    List<EmployeeVM> retrievedEmplyeeList();
    List<EmployeeVM> retrievedTeamMembers(int id);
    String updateIsOnCall(ITeam team);
    ITeam retrieveOnCallTeam();
}
