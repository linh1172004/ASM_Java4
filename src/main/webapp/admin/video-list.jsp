<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Video - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #0f0f0f; color: white; font-family: sans-serif; }
        .form-control { background-color: #1f1f1f; border: 1px solid #333; color: white; }
        .form-control:focus { background-color: #1f1f1f; color: white; border-color: red; box-shadow: none; }
        .table { --bs-table-bg: transparent; --bs-table-color: #ccc; }
        .table-hover tbody tr:hover { color: white; background-color: #222; }
        .card { background-color: #1e1e1e; border: 1px solid #333; }
        .preview-img { width: 100%; border-radius: 8px; margin-bottom: 10px; border: 1px solid #444; min-height: 150px; object-fit: cover; background: #000; }
    </style>
</head>
<body>

<nav class="navbar navbar-dark bg-black border-bottom border-secondary mb-4">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/index">
            <span class="text-danger fs-4">▶</span> QUẢN TRỊ VIÊN
        </a>
        <span class="text-secondary">Xin chào, ${sessionScope.user.fullname}</span>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">

        <div class="col-lg-4">
            <div class="card mb-3">
                <div class="card-header fw-bold border-secondary text-uppercase text-warning">
                    <i class="fa-solid fa-pen-to-square"></i> Thông tin Video
                </div>
                <div class="card-body">
                    <c:if test="${not empty message}"><div class="alert alert-success p-2 small">${message}</div></c:if>
                    <c:if test="${not empty error}"><div class="alert alert-danger p-2 small">${error}</div></c:if>

                    <form action="${pageContext.request.contextPath}/admin/video/create" method="post">

                        <div class="text-center">
                            <img id="poster-preview" src="${not empty video.poster ? video.poster : 'https://placehold.co/600x400/000000/FFFFFF?text=Preview'}" class="preview-img">
                        </div>

                        <div class="mb-3">
                            <label class="form-label text-secondary small fw-bold">LINK YOUTUBE HOẶC ID</label>
                            <input name="id" id="youtube-id" value="${video.id}" class="form-control" required
                                   placeholder="Dán link Youtube vào đây..." oninput="updatePreview()"
                            ${not empty video.id ? 'readonly' : ''}> </div>

                        <div class="mb-3">
                            <label class="form-label text-secondary small fw-bold">TIÊU ĐỀ VIDEO</label>
                            <input name="title" value="${video.title}" class="form-control" required placeholder="Nhập tiêu đề...">
                        </div>

                        <div class="mb-3">
                            <label class="form-label text-secondary small fw-bold">MÔ TẢ CHI TIẾT</label>
                            <textarea name="description" class="form-control" rows="4" placeholder="Nhập mô tả video...">${video.description}</textarea>
                        </div>

                        <hr class="border-secondary">

                        <div class="d-flex gap-2">
                            <button type="submit" class="btn btn-danger flex-grow-1" ${not empty video.id ? 'disabled' : ''}>
                                <i class="fa-solid fa-upload"></i> Đăng Video
                            </button>

                            <button type="submit" formaction="${pageContext.request.contextPath}/admin/video/update"
                                    class="btn btn-primary flex-grow-1" ${empty video.id ? 'disabled' : ''}>
                                <i class="fa-solid fa-check"></i> Lưu lại
                            </button>
                        </div>
                        <div class="mt-2">
                            <a href="${pageContext.request.contextPath}/admin/videos" class="btn btn-secondary w-100">
                                <i class="fa-solid fa-rotate-left"></i> Làm mới Form
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="col-lg-8">
            <div class="card border-secondary">
                <div class="card-header fw-bold border-secondary text-uppercase text-info">
                    <i class="fa-solid fa-list"></i> Danh sách Video
                </div>
                <div class="card-body p-0 table-responsive" style="max-height: 80vh;">
                    <table class="table table-hover mb-0 align-middle">
                        <thead class="table-dark">
                        <tr>
                            <th>Poster</th>
                            <th>Thông tin Video</th>
                            <th>Lượt xem</th>
                            <th class="text-end">Công cụ</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${videos}" var="item">
                            <tr>
                                <td width="120">
                                    <img src="https://img.youtube.com/vi/${item.id}/mqdefault.jpg" class="rounded" width="100%">
                                </td>
                                <td>
                                    <div class="fw-bold text-white">${item.title}</div>
                                    <div class="text-secondary small">ID: ${item.id}</div>
                                </td>
                                <td class="text-info fw-bold">${item.views}</td>
                                <td class="text-end">
                                    <a href="${pageContext.request.contextPath}/admin/video/edit?id=${item.id}" class="btn btn-sm btn-outline-warning mx-1">
                                        <i class="fa-solid fa-pen"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/video/delete?id=${item.id}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Bạn có chắc muốn xóa video này không?')">
                                        <i class="fa-solid fa-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function updatePreview() {
        let input = document.getElementById('youtube-id').value;
        let videoId = "";

        // Logic tách ID bằng Javascript để hiện ảnh ngay lập tức
        if (input.includes("v=")) {
            videoId = input.split('v=')[1].split('&')[0];
        } else if (input.includes("youtu.be/")) {
            videoId = input.split('youtu.be/')[1];
        } else {
            videoId = input;
        }

        if (videoId.length > 5) {
            document.getElementById('poster-preview').src = "https://img.youtube.com/vi/" + videoId + "/mqdefault.jpg";
        }
    }
</script>

</body>
</html>