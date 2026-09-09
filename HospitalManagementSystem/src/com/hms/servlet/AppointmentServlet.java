package com.hms.servlet;

import java.io.IOException;
import java.util.List;

import com.hms.dao.AppointmentDAO;
import com.hms.dao.DoctorDAO;
import com.hms.dao.PatientDAO;
import com.hms.model.Appointment;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/appointment")
public class AppointmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final AppointmentDAO appointmentDAO = new AppointmentDAO();
    private final PatientDAO patientDAO = new PatientDAO();
    private final DoctorDAO doctorDAO = new DoctorDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
			action = "list";
		}

        switch (action) {
            case "add":
                request.setAttribute("patients", patientDAO.getAllPatients());
                request.setAttribute("doctors", doctorDAO.getAllDoctors());
                request.getRequestDispatcher("/appointment/appointment-form.jsp").forward(request, response);
                break;
            case "delete":
                int delId = Integer.parseInt(request.getParameter("id"));
                appointmentDAO.deleteAppointment(delId);
                response.sendRedirect("appointment?action=list");
                break;
            case "list":
            default:
                List<Appointment> appointments = appointmentDAO.getAllAppointments();
                request.setAttribute("appointments", appointments);
                request.getRequestDispatcher("/appointment/appointment-list.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Appointment a = new Appointment();
        a.setPatientId(Integer.parseInt(request.getParameter("patientId")));
        a.setDoctorId(Integer.parseInt(request.getParameter("doctorId")));
        a.setAppointmentDate(request.getParameter("appointmentDate"));
        appointmentDAO.addAppointment(a);
        response.sendRedirect("appointment?action=list");
    }
}
