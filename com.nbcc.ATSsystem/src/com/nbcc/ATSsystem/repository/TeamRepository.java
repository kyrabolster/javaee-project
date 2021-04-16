/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATSsystem.repository;

import com.nbcc.ATSsystem.models.EmployeeVM;
import com.nbcc.ATSsystem.models.ITeam;
import com.nbcc.ATSsystem.models.TeamFactory;
import com.nbcc.dataaccess.DALFactory;
import com.nbcc.dataaccess.IDAL;
import com.nbcc.dataaccess.IParameter;
import com.nbcc.dataaccess.ParameterFactory;
import java.util.ArrayList;
import java.util.List;
import javax.sql.rowset.CachedRowSet;

/**
 *
 * @author Soyoung Kim
 * @date 2021-03-20
 */
public class TeamRepository extends BaseRepository implements ITeamRepository {

    private final String SPROC_INSERT_TEAM = "CALL InsertTeam(?,?,?,?,?);";
    private final String SPROC_RETRIEVE_EMPLOYEES = "CALL SelectEmployeesNotInTeam()";
    private final String SPROC_RETRIEVE_TEAM_ONCALL = "CALL SelectOnCallTeam()";

    private IDAL dataAccess;

    public TeamRepository() {
        dataAccess = DALFactory.createInstance();
    }

    @Override
    public int insertTeam(ITeam team) {
        int returnId = 0;

        List<Object> returnValues;

        List<IParameter> params = ParameterFactory.createListInstance();

        params.add(ParameterFactory.createInstance(team.getName()));
        params.add(ParameterFactory.createInstance(team.getIsOnCall()));
        params.add(ParameterFactory.createInstance(team.getEmpId1()));
        params.add(ParameterFactory.createInstance(team.getEmpId2()));

        params.add(ParameterFactory.createInstance(returnId, IParameter.Direction.OUT, java.sql.Types.INTEGER));

        returnValues = dataAccess.executeNonQuery(SPROC_INSERT_TEAM, params);

        try {
            if (returnValues != null) {
                returnId = Integer.parseInt(returnValues.get(0).toString());
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return returnId;

    }

    @Override
    public int updateTeam(ITeam team) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int deleteTeam(ITeam team) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public List<ITeam> retrieveTeams() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ITeam retrieveITeam(int id) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    public List<EmployeeVM> retrievedEmplyeeList() {
        List<EmployeeVM> retrievedEmplyeeList = new ArrayList<>();

        try {
            CachedRowSet cr = dataAccess.executeFill(SPROC_RETRIEVE_EMPLOYEES, null);

            while (cr.next()) {
                EmployeeVM emp = new EmployeeVM();
                emp.setId(super.getInt("id", cr));
                emp.setName(cr.getString("FullName"));

                retrievedEmplyeeList.add(emp);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return retrievedEmplyeeList;
    }

    public ITeam retrieveTeamOnCall() {
        ITeam team = TeamFactory.createInstance();

        try {
            CachedRowSet cr = dataAccess.executeFill(SPROC_RETRIEVE_TEAM_ONCALL, null);
            while (cr.next()) {
                team.setName(super.getString("Name", cr));
            }

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return team;
    }

}
