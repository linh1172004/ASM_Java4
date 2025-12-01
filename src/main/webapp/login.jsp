<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập - OE Cinema</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #0f0f0f; color: white; height: 100vh; display: flex; align-items: center; justify-content: center; }
        .login-card { background-color: #1e1e1e; padding: 40px; border-radius: 10px; width: 100%; max-width: 400px; box-shadow: 0 4px 10px rgba(0,0,0,0.5); }
        .form-control { background-color: #121212; border: 1px solid #333; color: white; }
        .form-control:focus { background-color: #121212; color: white; border-color: #3ea6ff; box-shadow: none; }
        .btn-primary { background-color: #3ea6ff; border: none; font-weight: bold; }
        .btn-primary:hover { background-color: #3083cc; }
    </style>
</head>
<body>

<div class="login-card">
    <h3 class="text-center mb-4 fw-bold"><span style="color: red;">▶</span> OE Cinema</h3>

    <c:if test="${not empty message}">
        <div class="alert alert-danger text-center p-2 small">${message}</div>
    </c:if>

    <form action="login" method="post">
        <div class="mb-3">
            <label class="form-label text-secondary">Tên đăng nhập</label>
            <input type="text" name="id" class="form-control" value="teonv" required>
        </div>
        <div class="mb-3">
            <label class="form-label text-secondary">Mật khẩu</label>
            <input type="password" name="password" class="form-control" value="123" required>
        </div>
        <button type="submit" class="btn btn-primary w-100 py-2 mt-2">ĐĂNG NHẬP</button>
    </form>

    <div class="text-center mt-3">
        <a href="register" class="text-decoration-none text-info small me-3 fw-bold">Chưa có tài khoản? Đăng ký ngay.</a>
        <span class="text-secondary small">|</span>
        <a href="index" class="text-decoration-none text-secondary small ms-3">Quay lại trang chủ</a>
    </div>
</div>

</body>
</html>