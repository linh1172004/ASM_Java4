<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng tải Video - OE Studio</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #0f0f0f; color: white; }
        .upload-zone { border: 2px dashed #444; border-radius: 10px; padding: 40px; text-align: center; cursor: pointer; background: #181818; transition: 0.3s; }
        .upload-zone:hover { border-color: #3ea6ff; background: #202020; }
        .form-control, .form-select { background-color: #121212; border: 1px solid #333; color: white; }
        .form-control:focus { background-color: #121212; color: white; border-color: #3ea6ff; box-shadow: none; }
    </style>
</head>
<body>

<nav class="navbar navbar-dark bg-dark border-bottom border-secondary mb-4">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold" href="index">
            <span class="text-danger fs-4">▶</span> OE Studio
        </a>
        <a href="index" class="btn btn-close btn-close-white"></a>
    </div>
</nav>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <h3 class="fw-bold mb-4">Tải video lên</h3>

            <c:if test="${not empty message}">
                <div class="alert alert-info">${message}</div>
            </c:if>

            <form action="upload" method="post" enctype="multipart/form-data">

                <div class="mb-4">
                    <label class="form-label text-secondary fw-bold">1. Chọn Video từ máy tính (.mp4)</label>
                    <input type="file" name="videoFile" class="form-control" accept="video/mp4" required>
                </div>

                <div class="mb-4">
                    <label class="form-label text-secondary fw-bold">2. Chọn Ảnh bìa (.jpg, .png)</label>
                    <input type="file" name="coverImage" class="form-control" accept="image/*" required>
                </div>

                <div class="mb-3">
                    <label class="form-label text-secondary">Tiêu đề (Bắt buộc)</label>
                    <input type="text" name="title" class="form-control" placeholder="Đặt tiêu đề cho video..." required>
                </div>

                <div class="mb-3">
                    <label class="form-label text-secondary">Mô tả</label>
                    <textarea name="description" class="form-control" rows="4" placeholder="Giới thiệu về video của bạn..."></textarea>
                </div>

                <div class="d-grid gap-2 mt-4">
                    <button type="submit" class="btn btn-primary fw-bold py-2">
                        <i class="fa-solid fa-cloud-arrow-up"></i> ĐĂNG TẢI NGAY
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>