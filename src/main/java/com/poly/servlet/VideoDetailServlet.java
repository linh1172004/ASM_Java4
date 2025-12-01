package com.poly.servlet;

import com.poly.dao.VideoDao;
import com.poly.dao.SubscriptionDao;
import com.poly.dao.FavoriteDao; // THÊM IMPORT MỚI
import com.poly.entity.Video;
import com.poly.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class VideoDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        VideoDao dao = new VideoDao();
        Video video = dao.findById(id);
        req.setAttribute("video", video);

        User user = (User) req.getSession().getAttribute("user");

        // 1. KIỂM TRA SUBSCRIPTION VÀ FAVORITE STATUS
        if (user != null && video != null && video.getUploader() != null) {

            // a. Subscription Check
            if (!user.getId().equals(video.getUploader().getId())) {
                SubscriptionDao subDao = new SubscriptionDao();
                boolean isSubscribed = subDao.isSubscribed(user.getId(), video.getUploader().getId());
                req.setAttribute("isSubscribed", isSubscribed);
                req.setAttribute("canSubscribe", true);
            }

            // b. Favorite Check (NEW)
            FavoriteDao favDao = new FavoriteDao();
            boolean isFavorited = favDao.isFavorited(user.getId(), video.getId());
            req.setAttribute("isFavorited", isFavorited); // Gửi trạng thái Like sang JSP
        } else {
            req.setAttribute("canSubscribe", false);
        }

        // 2. Lấy danh sách gợi ý
        req.setAttribute("videos", dao.findAll());
        req.getRequestDispatcher("/detail.jsp").forward(req, resp);
    }
}