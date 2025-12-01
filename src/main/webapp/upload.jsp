<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tải video lên - OE Studio</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card bg-dark text-white border-secondary shadow-lg">
                <div class="card-header border-secondary d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">Tải video lên</h5>
                    <a href="index" class="btn btn-close btn-close-white"></a>
                </div>
                <div class="card-body p-4">
                    <c:if test="${not empty message}"><div class="alert alert-info">${message}</div></c:if>

                    <form action="upload" method="post" enctype="multipart/form-data">
                        <div class="mb-4 text-center p-5 border border-2 border-dashed border-secondary rounded" style="background: #181818;">
                            <i class="fa-solid fa-cloud-arrow-up fs-1 mb-3 text-secondary"></i>
                            <h5>Chọn tệp video để tải lên</h5>
                            <input type="file" name="videoFile" class="form-control mt-3 bg-dark text-white border-secondary" accept="video/mp4" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Chọn ảnh thu nhỏ (Thumbnail)</label>
                            <input type="file" name="coverImage" class="form-control bg-dark text-white border-secondary" accept="image/*" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Tiêu đề (bắt buộc)</label>
                            <input type="text" name="title" class="form-control bg-dark text-white border-secondary" placeholder="Thêm tiêu đề mô tả video của bạn" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Mô tả</label>
                            <textarea name="description" class="form-control bg-dark text-white border-secondary" rows="4" placeholder="Giới thiệu về video của bạn"></textarea>
                        </div>

                        <div class="text-end">
                            <button type="submit" class="btn btn-primary fw-bold">TIẾP THEO</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>