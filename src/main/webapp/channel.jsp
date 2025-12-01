<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${channelUser.fullname} - Kênh của tôi</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <style>
        .channel-header { padding: 40px; background-color: #1a1a1a; margin-top: 56px; border-bottom: 1px solid #333; }
        .channel-avatar { width: 120px; height: 120px; border-radius: 50%; background: purple; line-height: 120px; font-size: 48px; }
        .video-meta { font-size: 0.85rem; color: #aaaaaa; margin-top: 4px; }
        .video-card-channel { background-color: transparent !important; border: none !important; cursor: pointer; transition: transform 0.2s; }
    </style>
</head>
<body>
<jsp:include page="header.jsp" />

<div class="channel-header">
    <div class="container-fluid">
        <div class="d-flex align-items-center gap-4">
            <div class="channel-avatar text-center fw-bold">${channelUser.fullname.substring(0,1)}</div>
            <div>
                <h1 class="text-white fw-bold">${channelUser.fullname}</h1>
                <div class="text-secondary small">@${channelUser.id} • 279 N người đăng ký</div>
                <c:if test="${sessionScope.user.id != channelUser.id}">
                    <a href="subscribe?channelId=${channelUser.id}&videoId=index" class="btn btn-danger mt-3 rounded-pill fw-bold">
                        ĐĂNG KÝ
                    </a>
                </c:if>
                <c:if test="${sessionScope.user.id == channelUser.id}">
                    <button class="btn btn-secondary mt-3 rounded-pill fw-bold" disabled>Quản lý video</button>
                </c:if>
            </div>
        </div>
    </div>
</div>

<div class="container-fluid" style="padding: 24px 40px;">
    <h5 class="fw-bold mb-3">Tải lên (${videos.size()})</h5>
    <div class="row row-cols-1 row-cols-md-4 g-3">
        <c:forEach items="${videos}" var="video">
            <div class="col">
                <div class="card video-card-channel">
                    <a href="video-detail?id=${video.id}">
                        <c:choose>
                            <c:when test="${video.id.contains('.')}"><img src="files/${video.poster}" class="card-img-top"></c:when>
                            <c:otherwise><img src="https://img.youtube.com/vi/${video.id}/mqdefault.jpg" class="card-img-top"></c:otherwise>
                        </c:choose>
                    </a>
                    <div class="card-body px-0 pt-2">
                        <h6 class="video-title mb-1"><a href="video-detail?id=${video.id}" class="text-white text-decoration-none">${video.title}</a></h6>
                        <div class="video-meta">
                            <div>${video.uploader.fullname}</div>
                            <div>${video.views} lượt xem</div>
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