<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký Tài khoản</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #0f0f0f; color: white; height: 100vh; display: flex; align-items: center; justify-content: center; }
        .register-card { background-color: #1e1e1e; padding: 40px; border-radius: 10px; width: 100%; max-width: 500px; box-shadow: 0 4px 10px rgba(0,0,0,0.5); }
        .form-control { background-color: #121212; border: 1px solid #333; color: white; }
        .form-control:focus { background-color: #121212; color: white; border-color: #3ea6ff; box-shadow: none; }
        .btn-primary { background-color: #cc0000; border: none; font-weight: bold; }
        .btn-primary:hover { background-color: #ff0000; }
    </style>
</head>
<body>

<div class="register-card">
    <h3 class="text-center mb-4 fw-bold text-white"><span style="color: red;">▶</span> ĐĂNG KÝ OE CINEMA</h3>

    <c:if test="${not empty error}">
        <div class="alert alert-danger text-center p-2 small">${error}</div>
    </c:if>
    <c:if test="${not empty message}">
        <div class="alert alert-success text-center p-2 small">${message}</div>
    </c:if>

    <form action="register" method="post">
        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label text-secondary">Tên đăng nhập (ID)</label>
                <input type="text" name="id" class="form-control" required>
            </div>
            <div class="col-md-6 mb-3">
                <label class="form-label text-secondary">Mật khẩu</label>
                <input type="password" name="password" class="form-control" required>
            </div>
        </div>

        <div class="mb-3">
            <label class="form-label text-secondary">Họ và tên</label>
            <input type="text" name="fullname" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label text-secondary">Địa chỉ Email</label>
            <input type="email" name="email" class="form-control" required>
        </div>

        <button type="submit" class="btn btn-primary w-100 py-2 mt-2">TẠO TÀI KHOẢN</button>
    </form>

    <div class="text-center mt-3">
        <a href="login" class="text-decoration-none text-secondary small">Đã có tài khoản? Đăng nhập ngay</a>
    </div>
</div>

</body>
</html>