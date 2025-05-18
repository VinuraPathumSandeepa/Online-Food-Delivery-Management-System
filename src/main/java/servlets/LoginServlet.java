package servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import modal.User;
import utils.UserHandle;

import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User loginUser = UserHandle.findUserByEmail(email);

        if (loginUser == null) {
            request.setAttribute("error", "Incorrect Email or Password");
            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.forward(request, response);
        } else if (loginUser.getPassword().equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("USER", loginUser);
            if (loginUser.isAdmin()) {
                response.sendRedirect("admin/Dashboard.jsp");
            } else if (loginUser.isCustomer()) {
                response.sendRedirect("MenuList.jsp");
            } else if (loginUser.isDelivery()) {
                response.sendRedirect("delivery/Dashboard.jsp");
            }
        } else {
            request.setAttribute("error", "Wrong password");
            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.forward(request, response);
        }
    }
}