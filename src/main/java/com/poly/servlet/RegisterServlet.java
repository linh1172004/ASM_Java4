package com.poly.servlet;

import com.poly.dao.UserDao;
import com.poly.entity.User;
import com.poly.utils.SendMailUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import org.apache.commons.beanutils.BeanUtils;

public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            req.setCharacterEncoding("UTF-8");

            User user = new User();
            BeanUtils.populate(user, req.getParameterMap());

            UserDao dao = new UserDao();
            if(dao.findById(user.getId()) != null) {
                req.setAttribute("error", "Tên đăng nhập đã tồn tại!");
            } else {
                user.setAdmin(false);
                dao.create(user);

                // Gửi email chào mừng
                String subject = "Chào mừng bạn đến với OE Cinema!";
                String content = "Xin chào " + user.getFullname() + ",\n\n"
                        + "Chúc mừng bạn đã đăng ký tài khoản thành công tại OE Cinema.\n"
                        + "Tên đăng nhập của bạn là: " + user.getId() + "\n";

                SendMailUtils.send(user.getEmail(), subject, content);

                req.setAttribute("message", "Đăng ký thành công! Vui lòng kiểm tra email.");
            }

        } catch (Exception e) {
            req.setAttribute("error", "Lỗi: " + e.getMessage());
            e.printStackTrace();
        }

        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }
}