package com.poly.servlet;

import com.poly.dao.VideoDao;
import com.poly.entity.Video;
import com.poly.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import org.apache.commons.beanutils.BeanUtils;

public class VideoManageServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. Chặn nếu không phải Admin
        User user = (User) req.getSession().getAttribute("user");
        if (user == null || !user.getAdmin()) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String uri = req.getRequestURI();
        VideoDao dao = new VideoDao();
        String message = "";
        String error = "";

        try {
            // --- CHỨC NĂNG 1: LOAD FORM SỬA ---
            if (uri.contains("edit")) {
                String id = req.getParameter("id");
                Video video = dao.findById(id);
                req.setAttribute("video", video);
            }
            // --- CHỨC NĂNG 2: THÊM MỚI (UPDATE LOGIC XỊN) ---
            else if (uri.contains("create")) {
                String rawId = req.getParameter("id");
                String videoId = extractYoutubeId(rawId); // Tự tách ID từ link

                if (dao.findById(videoId) != null) {
                    error = "Thất bại: Video ID này đã tồn tại!";
                } else {
                    Video video = new Video();
                    BeanUtils.populate(video, req.getParameterMap());
                    video.setId(videoId); // Lưu ID chuẩn
                    video.setPoster("https://img.youtube.com/vi/" + videoId + "/mqdefault.jpg");
                    video.setActive(true);
                    video.setViews(0);

                    dao.create(video);
                    message = "Thêm mới thành công video: " + videoId;
                }
            }
            // --- CHỨC NĂNG 3: CẬP NHẬT ---
            else if (uri.contains("update")) {
                String videoId = req.getParameter("id"); // ID không được sửa
                Video video = dao.findById(videoId);

                if(video != null) {
                    video.setTitle(req.getParameter("title"));
                    video.setDescription(req.getParameter("description"));
                    // Nếu muốn cho sửa cả link ảnh thủ công thì thêm vào đây
                    // video.setPoster(req.getParameter("poster"));

                    dao.update(video);
                    message = "Cập nhật thành công!";
                } else {
                    error = "Lỗi: Không tìm thấy video để cập nhật!";
                }
            }
            // --- CHỨC NĂNG 4: XÓA ---
            else if (uri.contains("delete")) {
                String id = req.getParameter("id");
                dao.delete(id);
                message = "Xóa thành công!";
            }
        } catch (Exception e) {
            error = "Lỗi hệ thống: " + e.getMessage();
            e.printStackTrace();
        }

        req.setAttribute("message", message);
        req.setAttribute("error", error);
        req.setAttribute("videos", dao.findAll());
        req.getRequestDispatcher("/admin/video-list.jsp").forward(req, resp);
    }

    // Hàm phụ: Tách ID từ link Youtube bất kỳ
    private String extractYoutubeId(String url) {
        if (url == null) return "";
        // Nếu là link full: https://www.youtube.com/watch?v=VIDEO_ID
        if (url.contains("v=")) {
            return url.split("v=")[1].split("&")[0];
        }
        // Nếu là link ngắn: https://youtu.be/VIDEO_ID
        if (url.contains("youtu.be/")) {
            return url.split("youtu.be/")[1];
        }
        // Nếu người dùng nhập thẳng ID
        return url;
    }
}