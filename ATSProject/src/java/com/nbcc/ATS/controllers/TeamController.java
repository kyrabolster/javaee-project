/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATS.controllers;

import com.nbcc.ATS.models.ErrorViewModel;
import com.nbcc.ATSsystem.business.ITeamService;
import com.nbcc.ATSsystem.business.TeamServiceFactory;
import com.nbcc.ATSsystem.models.EmployeeVM;
import com.nbcc.ATSsystem.models.ITeam;
import com.nbcc.ATSsystem.models.TeamFactory;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Soyoung Kim
 * @date 2021-03-20
 */
public class TeamController extends CommonController {

    private static final String TEAMS_MAINT_VIEW = "/team.jsp";
    private static final String TEAM_SUMMARY_VIEW = "/teamsummary.jsp";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        ITeamService teamService = TeamServiceFactory.createInstance();
        List<EmployeeVM> employeeList = teamService.getEmployees();
        request.setAttribute("employeesList", employeeList);

        if (pathInfo != null) {
            String[] pathParts = pathInfo.split("/");

            int id = super.getInteger(pathParts[1]);
            //Get the team in a variable
            ITeam team = teamService.getTeam(id);

            //Set attribute as team or error
            if (team != null) {
                request.setAttribute("team", team);
            } else {
                request.setAttribute("error", new ErrorViewModel(String.format("Team ID: $s is not found", id)));
            }
            super.setView(request, TEAMS_MAINT_VIEW);
        } else {
            //Set attribute as list of the invoices
            //when implement show teams
            //request.setAttribute("teams", teamService.getTeams());
            super.setView(request, TEAMS_MAINT_VIEW);
        }

        super.getView().forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        super.setView(request, TEAM_SUMMARY_VIEW);

        ITeamService teamService = TeamServiceFactory.createInstance();
        ITeam team;
        List<EmployeeVM> assignedEmps;

        try {
            String action = super.getValue(request, "action");
            int id = super.getInteger(request, "hdnTaskId");

            switch (action.toLowerCase()) {
                case "create":
                    team = setTeam(request);
                    team = teamService.createTeam(team);
                    assignedEmps = getAssignedEmp(request);

                    request.setAttribute("team", team);
                    request.setAttribute("emp1", assignedEmps.get(0));
                    request.setAttribute("emp2", assignedEmps.get(1));

                    if (!teamService.isValid(team)) {
                        request.setAttribute("error", team.getErrors());
                        super.setView(request, TEAMS_MAINT_VIEW);
                    }

                    break;
                case "save":

                    break;
                case "delete":

                    break;
            }

        } catch (Exception e) {
            super.setView(request, TEAMS_MAINT_VIEW);
            request.setAttribute("error", new ErrorViewModel("An error occurred attempting to maintain teams"));
        }

        super.getView().forward(request, response);
    }

    private ITeam setTeam(HttpServletRequest request) {
        String name;
        boolean isOnCall;
        int emp1;
        int emp2;

        name = getValue(request, "teamName");
        isOnCall = getDouble(request, "isOnCall") != 0;
        emp1 = getInteger(request, "teamMember1");
        emp2 = getInteger(request, "teamMember2");

        ITeam team = TeamFactory.createInstance(name, isOnCall, emp1, emp2);

        return team;
    }

    private List<EmployeeVM> getAssignedEmp(HttpServletRequest request) {
        ITeamService teamService = TeamServiceFactory.createInstance();
        
        List<EmployeeVM> employeeList = teamService.getEmployees();
        
        int memberId1 = getInteger(request, "teamMember1");
        int memberId2 = getInteger(request, "teamMember2");

        List<EmployeeVM> query = employeeList.stream().filter(e -> e.getId() == memberId1 || e.getId() == memberId2).collect(Collectors.toList());

        return query;
    }
}
