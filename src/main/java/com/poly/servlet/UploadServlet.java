package com.poly.servlet;

import com.poly.dao.VideoDao;
import com.poly.entity.Video;
import com.poly.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 100,
        maxRequestSize = 1024 * 1024 * 150
)
public class UploadServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect("login");
            return;
        }
        req.getRequestDispatcher("/upload.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy thông tin user hiện tại (chủ kênh)
        User uploader = (User) req.getSession().getAttribute("user");
        if (uploader == null) { resp.sendRedirect("login"); return; } // Chặn nếu session hết hạn

        try {
            String title = req.getParameter("title");
            String desc = req.getParameter("description");

            Part videoPart = req.getPart("videoFile");
            String videoFileName = Paths.get(videoPart.getSubmittedFileName()).getFileName().toString();

            String uploadPath = req.getServletContext().getRealPath("/files");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            videoPart.write(uploadPath + File.separator + videoFileName);

            Part imagePart = req.getPart("coverImage");
            String imageFileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
            imagePart.write(uploadPath + File.separator + imageFileName);

            VideoDao dao = new VideoDao();
            Video video = new Video();
            video.setId(videoFileName);
            video.setTitle(title);
            video.setDescription(desc);
            video.setPoster("files/" + imageFileName);
            video.setViews(0);
            video.setActive(true);

            // THIẾT LẬP CHỦ SỞ HỮU (Dùng user lấy từ Session)
            video.setUploader(uploader);

            dao.create(video);

            req.setAttribute("message", "Đăng video thành công!");
            req.getRequestDispatcher("/upload.jsp").forward(req, resp);

        } catch (Exception e) {
            req.setAttribute("message", "Lỗi: " + e.getMessage());
            req.getRequestDispatcher("/upload.jsp").forward(req, resp);
        }
    }
}