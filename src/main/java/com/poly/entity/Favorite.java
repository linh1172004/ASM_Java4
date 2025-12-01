package com.poly.entity;

import jakarta.persistence.*; // Đã đổi từ javax sang jakarta
import java.util.Date;

@Entity
@Table(name = "Favorites", uniqueConstraints = {
        @UniqueConstraint(columnNames = {"UserId", "VideoId"})
})
public class Favorite {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "UserId")
    private User user;

    @ManyToOne
    @JoinColumn(name = "VideoId")
    private Video video;

    @Temporal(TemporalType.DATE)
    @Column(name = "LikeDate")
    private Date likeDate = new Date();

    // Getter & Setter
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
    public Video getVideo() { return video; }
    public void setVideo(Video video) { this.video = video; }
    public Date getLikeDate() { return likeDate; }
    public void setLikeDate(Date likeDate) { this.likeDate = likeDate; }
}