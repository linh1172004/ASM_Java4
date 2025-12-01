package com.poly.servlet;

import com.poly.dao.VideoDao;
import com.poly.dao.UserDao;
import com.poly.entity.User;
import com.poly.entity.Video;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class ChannelServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String channelId = req.getParameter("id"); // Lấy ID của chủ kênh

        if (channelId == null) {
            resp.sendRedirect("index"); // Nếu không có ID thì về trang chủ
            return;
        }

        UserDao userDao = new UserDao();
        VideoDao videoDao = new VideoDao();

        // 1. Lấy thông tin chủ kênh
        User channelUser = userDao.findById(channelId);

        // 2. Lấy danh sách video của kênh đó
        List<Video> videos = videoDao.findByUser(channelId);

        req.setAttribute("channelUser", channelUser);
        req.setAttribute("videos", videos);

        req.getRequestDispatcher("/channel.jsp").forward(req, resp);
    }
}