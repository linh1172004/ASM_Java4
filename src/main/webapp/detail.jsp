<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${video.title} - OE Cinema</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <style>
        .video-player-frame { position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; border-radius: 12px; background: #000; }
        .video-player-frame iframe, .video-player-frame video { position: absolute; top: 0; left: 0; width: 100%; height: 100%; }
        /* Style cho nút Subscribe */
        .btn-subscribe { background-color: #cc0000; color: white; border-radius: 18px; font-weight: 600; padding: 0 16px; height: 36px; display: inline-flex; align-items: center; text-decoration: none; }
        .btn-subscribed { background-color: #272727; color: white; border-radius: 18px; font-weight: 600; padding: 0 16px; height: 36px; display: inline-flex; align-items: center; text-decoration: none; }
        .btn-gray { background-color: #272727; color: white; border: none; border-radius: 18px; padding: 6px 12px; font-size: 0.9rem; font-weight: 500; display: flex; align-items: center; gap: 6px; }
    </style>
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
            <form class="d-flex w-100" action="search" method="get">
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
                    <a href="login" class="btn btn-outline-secondary rounded-pill text-primary fw-bold px-3 py-1 border-secondary">Đăng nhập</a>
                </c:when>
                <c:otherwise>
                    <div class="dropdown">
                        <button class="btn-icon" data-bs-toggle="dropdown"><i class="fa-solid fa-video fs-5"></i></button>
                        <ul class="dropdown-menu dropdown-menu-dark dropdown-menu-end">
                            <li><a class="dropdown-item" href="upload">Tải video lên</a></li>
                        </ul>
                    </div>
                    <div class="position-relative">
                        <button class="btn-icon"><i class="fa-regular fa-bell fs-5"></i></button>
                        <span class="notification-badge">9+</span>
                    </div>
                    <div class="dropdown">
                        <button class="btn-icon" data-bs-toggle="dropdown" style="padding: 0;">
                            <div style="width: 32px; height: 32px; background: purple; border-radius: 50%; text-align: center; line-height: 32px; font-weight: bold; font-size: 14px;">${sessionScope.user.fullname.substring(0,1)}</div>
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

<div class="container-fluid" style="margin-top: 70px; padding: 0 50px;">
    <div class="row">
        <div class="col-lg-8">
            <div class="video-player-frame mb-3">
                <c:choose>
                    <c:when test="${video.id.contains('.')}">
                        <video controls autoplay><source src="files/${video.id}" type="video/mp4"></video>
                    </c:when>
                    <c:otherwise>
                        <iframe src="https://www.youtube.com/embed/${video.id}?autoplay=1" frameborder="0" allowfullscreen></iframe>
                    </c:otherwise>
                </c:choose>
            </div>

            <h4 class="fw-bold mb-2">${video.title}</h4>

            <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
                <div class="d-flex align-items-center gap-3">
                    <div style="width: 40px; height: 40px; background: #aaa; border-radius: 50%;"></div>
                    <div>
                        <h6 class="mb-0 fw-bold">
                            <a href="channel?id=${video.uploader.id}" class="text-white text-decoration-none">
                                ${video.uploader.fullname} <i class="fa-solid fa-circle-check text-secondary small"></i>
                            </a>
                        </h6>
                        <small class="text-secondary">279 N người đăng ký</small>
                    </div>

                    <c:if test="${canSubscribe}">
                        <a href="subscribe?channelId=${video.uploader.id}&videoId=${video.id}"
                           class="ms-3 ${isSubscribed ? 'btn-subscribed' : 'btn-subscribe'}">
                            <c:choose>
                                <c:when test="${isSubscribed}">
                                    <i class='fa-regular fa-bell me-1'></i> Đã đăng ký
                                </c:when>
                                <c:otherwise>
                                    Đăng ký
                                </c:otherwise>
                            </c:choose>
                        </a>
                    </c:if>
                    <c:if test="${empty sessionScope.user}"><a href="login" class="ms-3 btn-subscribe">Đăng ký</a></c:if>
                </div>

                <div class="d-flex align-items-center gap-2">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <div class="btn-group rounded-pill border-0" role="group">
                                <a href="favorite?videoId=${video.id}"
                                   class="btn ${isFavorited ? 'btn-danger' : 'btn-gray'} rounded-start-pill fw-bold"
                                   style="border-right: 1px solid #555; text-decoration: none;">
                                    <i class="fa-regular fa-thumbs-up"></i>
                                    LIKE
                                </a>
                                <a href="favorite?videoId=${video.id}" class="btn btn-gray rounded-end-pill fw-bold" style="text-decoration: none;">
                                    <i class="fa-regular fa-thumbs-down"></i> DISLIKE
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <a href="login" class="btn btn-gray rounded-start-pill fw-bold" style="border-right: 1px solid #555; text-decoration: none;">
                                <i class="fa-regular fa-thumbs-up"></i> LIKE
                            </a>
                            <a href="login" class="btn btn-gray rounded-end-pill fw-bold" style="text-decoration: none;">
                                <i class="fa-regular fa-thumbs-down"></i> DISLIKE
                            </a>
                        </c:otherwise>
                    </c:choose>

                    <button class="btn btn-gray"><i class="fa-solid fa-share"></i> Chia sẻ</button>
                    <button class="btn btn-gray"><i class="fa-solid fa-ellipsis"></i></button>
                </div>
            </div>

            <div class="p-3 rounded" style="background-color: #272727; cursor: pointer;">
                <div class="fw-bold small mb-2">${video.views} lượt xem • Hôm nay</div>
                <p class="mb-0 small text-white" style="white-space: pre-line;">${video.description}</p>
            </div>

            <div class="mt-4">
                <h5>245 bình luận</h5>
                <div class="d-flex gap-3 my-3">
                    <div style="width: 40px; height: 40px; background: purple; border-radius: 50%; text-align: center; line-height: 40px;">${not empty sessionScope.user ? sessionScope.user.fullname.substring(0,1) : '?'}</div>
                    <input type="text" class="form-control bg-transparent border-0 border-bottom border-secondary text-white" placeholder="Viết bình luận...">
                </div>
            </div>
        </div>

        <div class="col-lg-4 ps-4">
            <c:forEach items="${videos}" var="item">
                <div class="card mb-2 bg-transparent border-0 p-0">
                    <div class="row g-0">
                        <div class="col-5">
                            <a href="video-detail?id=${item.id}">
                                <c:choose>
                                    <c:when test="${item.id.contains('.')}"><img src="${item.poster}" class="img-fluid rounded" style="height: 94px; width: 168px; object-fit: cover;"></c:when>
                                    <c:otherwise><img src="https://img.youtube.com/vi/${item.id}/mqdefault.jpg" class="img-fluid rounded" style="height: 94px; width: 168px; object-fit: cover;"></c:otherwise>
                                </c:choose>
                            </a>
                        </div>
                        <div class="col-7 ps-2">
                            <h6 class="card-title mb-1" style="font-size: 0.9rem; line-height: 1.2; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                                <a href="video-detail?id=${item.id}">${item.title}</a>
                            </h6>
                            <small class="text-secondary" style="font-size: 0.8rem; display: block;">OE Cinema</small>
                            <small class="text-secondary" style="font-size: 0.8rem;">${item.views} views • 2 ngày trước</small>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>