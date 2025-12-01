package com.poly.servlet;

import com.poly.dao.VideoDao;
import com.poly.entity.Video;
import jakarta.servlet.ServletException;            // Đã đổi sang jakarta
import jakarta.servlet.annotation.WebServlet;       // Đã đổi sang jakarta
import jakarta.servlet.http.HttpServlet;            // Đã đổi sang jakarta
import jakarta.servlet.http.HttpServletRequest;     // Đã đổi sang jakarta
import jakarta.servlet.http.HttpServletResponse;    // Đã đổi sang jakarta
import java.io.IOException;
import java.util.List;

public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        VideoDao dao = new VideoDao();
        List<Video> list = dao.findAll();

        req.setAttribute("videos", list);
        req.getRequestDispatcher("/index.jsp").forward(req, resp);
    }
}