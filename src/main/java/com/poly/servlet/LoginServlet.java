package com.poly.servlet;

import com.poly.dao.UserDao;
import com.poly.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

// ĐÃ XÓA @WebServlet ĐỂ TRÁNH XUNG ĐỘT VỚI WEB.XML
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        String pass = req.getParameter("password");

        UserDao dao = new UserDao();
        User user = dao.findById(id);

        if(user != null && user.getPassword().equals(pass)) {
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            resp.sendRedirect("index");
        } else {
            req.setAttribute("message", "Sai tên đăng nhập hoặc mật khẩu!");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }
}