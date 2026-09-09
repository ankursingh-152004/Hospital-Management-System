package com.hms.servlet;

import java.io.IOException;
import java.util.List;

import com.hms.dao.PatientDAO;
import com.hms.model.Patient;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/patient")
public class PatientServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final PatientDAO patientDAO = new PatientDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
			action = "list";
		}

        switch (action) {
            case "add":
                request.getRequestDispatcher("/patient/patient-form.jsp").forward(request, response);
                break;
            case "edit":
                int editId = Integer.parseInt(request.getParameter("id"));
                Patient p = patientDAO.getPatientById(editId);
                request.setAttribute("patient", p);
                request.getRequestDispatcher("/patient/patient-form.jsp").forward(request, response);
                break;
            case "delete":
                int delId = Integer.parseInt(request.getParameter("id"));
                patientDAO.deletePatient(delId);
                response.sendRedirect("patient?action=list");
                break;
            case "list":
            default:
                List<Patient> patients = patientDAO.getAllPatients();
                request.setAttribute("patients", patients);
                request.getRequestDispatcher("/patient/patient-list.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        Patient p = new Patient();
        p.setName(request.getParameter("name"));
        p.setAge(Integer.parseInt(request.getParameter("age")));
        p.setGender(request.getParameter("gender"));
        p.setPhone(request.getParameter("phone"));
        p.setAddress(request.getParameter("address"));
        p.setDisease(request.getParameter("disease"));

        if ("update".equals(action)) {
            p.setId(Integer.parseInt(request.getParameter("id")));
            patientDAO.updatePatient(p);
        } else {
            patientDAO.addPatient(p);
        }
        response.sendRedirect("patient?action=list");
    }
}
