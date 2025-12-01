package com.poly.servlet;

import com.poly.dao.SubscriptionDao;
import com.poly.dao.UserDao; // Cần dùng để tìm chủ kênh
import com.poly.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class SubscriptionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. Kiểm tra đăng nhập (BẮT BUỘC theo yêu cầu Assignment)
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect("login"); // Nếu chưa đăng nhập thì chặn lại
            return;
        }

        // 2. Lấy ID chủ kênh từ URL (được gửi từ detail.jsp)
        String channelId = req.getParameter("channelId");

        // 3. Xử lý logic
        if (channelId != null) {
            UserDao userDao = new UserDao();
            User channel = userDao.findById(channelId);

            if (channel != null) {
                SubscriptionDao subDao = new SubscriptionDao();
                subDao.toggleSubscription(user, channel);
            }
        }

        // 4. Quay lại trang xem video
        String videoId = req.getParameter("videoId"); // ID video đang xem
        resp.sendRedirect("video-detail?id=" + videoId);
    }
}