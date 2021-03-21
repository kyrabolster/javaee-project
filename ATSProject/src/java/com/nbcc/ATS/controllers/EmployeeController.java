/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATS.controllers;

import com.nbcc.ATS.models.ErrorViewModel;
import com.nbcc.ATSsystem.business.EmployeeServiceFactory;
import com.nbcc.ATSsystem.business.IEmployeeService;
import com.nbcc.ATSsystem.models.IEmployee;
import com.nbcc.ATSsystem.models.EmployeeFactory;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author KyraB
 */
public class EmployeeController extends CommonController {

    private static final String EMPLOYEES_VIEW = "/employees.jsp";
    private static final String EMPLOYEES_MAINT_VIEW = "/employee.jsp";
    private static final String EMPLOYEE_SUMMARY_VIEW = "/employeesummary.jsp";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        //Service Instance
        IEmployeeService employeeService = EmployeeServiceFactory.createInstance();

        if (pathInfo != null) {
            String[] pathParts = pathInfo.split("/");

            int id = super.getInteger(pathParts[1]);
            //Get the invoice in a variable
            IEmployee employee = employeeService.getEmployee(id);

            //Set attribute as invoice or error
            if (employee != null) {
                request.setAttribute("employee", employee);

            } else {
                request.setAttribute("error", new ErrorViewModel(String.format("Employee ID: $s is not found", id)));
            }
            super.setView(request, EMPLOYEES_MAINT_VIEW);
        } else {
            //Set attribute as list of the invoices
            request.setAttribute("employees", employeeService.getEmployees());
            super.setView(request, EMPLOYEES_VIEW);
        }

        super.getView().forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        super.setView(request, EMPLOYEE_SUMMARY_VIEW);

        IEmployeeService employeeService = EmployeeServiceFactory.createInstance();
        IEmployee employee;

        try {
            String action = super.getValue(request, "action");
            int id = super.getInteger(request, "hdnEmployeeId");

            switch (action.toLowerCase()) {
                case "create":
                    employee = setEmployee(request);
                    employee = employeeService.createEmployee(employee);

                    request.setAttribute("employee", employee);

                    if (!employeeService.isValid(employee)) {
                        request.setAttribute("error", employee.getErrors());
                        super.setView(request, EMPLOYEES_MAINT_VIEW);
                    }

                    break;
                case "save":

                    break;
                case "delete":

                    break;
            }
        } catch (Exception e) {
            super.setView(request, EMPLOYEES_MAINT_VIEW);
            request.setAttribute("error", new ErrorViewModel("An error occurred attempting to maintain employees"));
        }

        super.getView().forward(request, response);
    }

    private IEmployee setEmployee(HttpServletRequest request) {
        String firstName;
        String lastName;
        String SIN;
        double hourlyRate;

        firstName = getValue(request, "firstName");
        lastName = getValue(request, "lastName");
        SIN = getValue(request, "SIN");
        hourlyRate = getDouble(request, "hourlyRate");

        IEmployee employee = EmployeeFactory.createInstance(firstName, lastName, SIN, hourlyRate);

        return employee;
    }
}
