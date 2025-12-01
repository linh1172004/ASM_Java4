<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>OE Cinema - YouTube</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body>

<nav class="navbar fixed-top">
    <div class="d-flex align-items-center w-100 justify-content-between">
        <div class="d-flex align-items-center gap-3">
            <button class="btn-icon"><i class="fa-solid fa-bars fs-5"></i></button>
            <a class="navbar-brand d-flex align-items-center gap-1" href="index" style="margin-right: 0;">
                <i class="fa-brands fa-youtube text-danger fs-3"></i>
                <span style="font-weight: 600; letter-spacing: -1px;">OE Cinema</span>
            </a>
        </div>

        <div class="d-flex align-items-center flex-grow-1 justify-content-center" style="max-width: 600px;">
            <form action="search" method="get" class="d-flex w-100">
                <div class="input-group">
                    <input type="text" name="keyword" class="form-control rounded-start-pill border-secondary bg-black" placeholder="Tìm kiếm">
                    <button class="btn btn-dark rounded-end-pill border-secondary bg-dark px-4" type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
                </div>
                <button type="button" class="btn-icon ms-3 bg-dark" style="width: 40px; height: 40px;"><i class="fa-solid fa-microphone"></i></button>
            </form>
        </div>
        <div class="d-flex align-items-center gap-2">
            <c:choose>
                <c:when test="${empty sessionScope.user}">
                    <div class="dropdown"><button class="btn-icon"><i class="fa-solid fa-ellipsis-vertical"></i></button></div>
                    <a href="login" class="btn btn-outline-secondary rounded-pill text-primary fw-bold px-3 py-1 border-secondary d-flex align-items-center gap-2" style="font-size: 0.9rem;">
                        <i class="fa-regular fa-circle-user fs-5"></i> Đăng nhập
                    </a>
                </c:when>
                <c:otherwise>
                    <div class="dropdown">
                        <button class="btn-icon" data-bs-toggle="dropdown"><i class="fa-solid fa-video fs-5"></i><span style="position: absolute;font-size:10px;top:10px;">+</span></button>
                        <ul class="dropdown-menu dropdown-menu-dark dropdown-menu-end">
                            <li><a class="dropdown-item" href="upload">Tải video lên</a></li>
                            <li><a class="dropdown-item" href="#"><i class="fa-solid fa-tower-broadcast"></i> Phát trực tiếp</a></li>
                        </ul>
                    </div>
                    <div class="position-relative">
                        <button class="btn-icon"><i class="fa-regular fa-bell fs-5"></i></button>
                        <span class="notification-badge">9+</span>
                    </div>
                    <div class="dropdown">
                        <button class="btn-icon" data-bs-toggle="dropdown" style="padding: 0;">
                            <div style="width: 32px; height: 32px; background: purple; border-radius: 50%; text-align: center; line-height: 32px; font-weight: bold; font-size: 14px;">
                                    ${sessionScope.user.fullname.substring(0,1)}
                            </div>
                        </button>
                        <ul class="dropdown-menu dropdown-menu-dark dropdown-menu-end mt-2">
                            <li><div class="px-3 py-2 fw-bold">${sessionScope.user.fullname}</div></li>
                            <li><hr class="dropdown-divider border-secondary"></li>
                            <c:if test="${sessionScope.user.admin}">
                                <li><a class="dropdown-item text-warning" href="admin/videos">Quản trị Admin</a></li>
                            </c:if>
                            <li><a class="dropdown-item" href="logoff">Đăng xuất</a></li>
                        </ul>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</nav>

<div class="container-fluid" style="margin-top: 70px; padding: 0 24px;">
    <h5 class="fw-bold mb-3">Đề xuất cho bạn</h5>
    <div class="row row-cols-1 row-cols-md-3 row-cols-lg-4 g-3">
        <c:forEach items="${videos}" var="video">
            <div class="col">
                <div class="card video-card">
                    <a href="video-detail?id=${video.id}">
                        <c:choose>
                            <c:when test="${video.id.contains('.')}"><img src="${video.poster}" class="card-img-top"></c:when>
                            <c:otherwise><img src="https://img.youtube.com/vi/${video.id}/mqdefault.jpg" class="card-img-top"></c:otherwise>
                        </c:choose>
                    </a>
                    <div class="card-body px-0 pt-2">
                        <div class="d-flex gap-2">
                            <div style="width: 36px; height: 36px; background: #aaa; border-radius: 50%;"></div>
                            <div>
                                <h6 class="video-title mb-1"><a href="video-detail?id=${video.id}">${video.title}</a></h6>
                                <div class="video-meta">
                                    <div>OE Cinema Official <i class="fa-solid fa-circle-check"></i></div>
                                    <div>${video.views} lượt xem • 2 giờ trước</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>