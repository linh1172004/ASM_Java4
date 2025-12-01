package com.poly.servlet;

import com.poly.dao.FavoriteDao;
import com.poly.dao.VideoDao;
import com.poly.entity.User;
import com.poly.entity.Video;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class FavoriteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. Kiểm tra đăng nhập (Yêu cầu bảo mật)
        User user = (User) req.getSession().getAttribute("user");
        String videoId = req.getParameter("videoId");

        if (user == null) {
            // Chặn và đẩy về trang login để người dùng đăng nhập trước
            resp.sendRedirect("login");
            return;
        }

        // 2. Xử lý Like/Unlike
        if (videoId != null) {
            VideoDao videoDao = new VideoDao();
            FavoriteDao favoriteDao = new FavoriteDao();
            Video video = videoDao.findById(videoId);

            if (video != null) {
                favoriteDao.toggleFavorite(user, video);
            }
        }

        // 3. Quay lại trang xem video
        resp.sendRedirect("video-detail?id=" + videoId);
    }
}