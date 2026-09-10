package com.hms.servlet;

import java.io.IOException;
import java.util.List;

import com.hms.dao.DoctorDAO;
import com.hms.model.Doctor;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/doctor")
public class DoctorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
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
                request.getRequestDispatcher("/doctor/doctor-form.jsp").forward(request, response);
                break;
            case "edit":
                int editId = Integer.parseInt(request.getParameter("id"));
                Doctor d = doctorDAO.getDoctorById(editId);
                request.setAttribute("doctor", d);
                request.getRequestDispatcher("/doctor/doctor-form.jsp").forward(request, response);
                break;
            case "delete":
                int delId = Integer.parseInt(request.getParameter("id"));
                doctorDAO.deleteDoctor(delId);
                response.sendRedirect("doctor?action=list");
                break;
            case "list":
            default:
                List<Doctor> doctors = doctorDAO.getAllDoctors();
                request.setAttribute("doctors", doctors);
                request.getRequestDispatcher("/doctor/doctor-list.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        Doctor d = new Doctor();
        d.setName(request.getParameter("name"));
        d.setSpecialization(request.getParameter("specialization"));
        d.setPhone(request.getParameter("phone"));
        d.setEmail(request.getParameter("email"));

        if ("update".equals(action)) {
            d.setId(Integer.parseInt(request.getParameter("id")));
            doctorDAO.updateDoctor(d);
        } else {
            doctorDAO.addDoctor(d);
        }
        response.sendRedirect("doctor?action=list");
    }
}
