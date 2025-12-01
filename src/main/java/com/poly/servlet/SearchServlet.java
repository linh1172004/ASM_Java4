package com.poly.servlet;

import com.poly.dao.VideoDao;
import com.poly.entity.Video;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class SearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String keyword = req.getParameter("keyword");

        VideoDao dao = new VideoDao();
        List<Video> list = null;

        if (keyword != null && !keyword.trim().isEmpty()) {
            list = dao.findByKeyword(keyword);
            req.setAttribute("keyword", keyword); // Giữ lại từ khóa tìm kiếm
        } else {
            // Nếu không có từ khóa, hiển thị tất cả (giống trang chủ)
            list = dao.findAll();
        }

        req.setAttribute("videos", list);
        req.getRequestDispatcher("/index.jsp").forward(req, resp);
    }
}