package com.poly.entity;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "Videos")
public class Video {
    @Id
    @Column(name = "Id")
    private String id;

    @Column(name = "Title")
    private String title;

    @Column(name = "Poster")
    private String poster;

    @Column(name = "Views")
    private Integer views = 0;

    @Column(name = "Description")
    private String description;

    @Column(name = "Active")
    private Boolean active = true;

    // --- THÊM TRƯỜNG CHỦ SỞ HỮU (Uploader) ---
    @ManyToOne @JoinColumn(name = "UploaderId")
    private User uploader;
    // ----------------------------------------

    @OneToMany(mappedBy = "video")
    private List<Favorite> favorites;

    @OneToMany(mappedBy = "video")
    private List<Share> shares;

    // Getter/Setter
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getPoster() { return poster; }
    public void setPoster(String poster) { this.poster = poster; }
    public Integer getViews() { return views; }
    public void setViews(Integer views) { this.views = views; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public Boolean getActive() { return active; }
    public void setActive(Boolean active) { this.active = active; }

    // GETTER/SETTER MỚI CHO UPLOADER
    public User getUploader() { return uploader; }
    public void setUploader(User uploader) { this.uploader = uploader; }

    public List<Favorite> getFavorites() { return favorites; }
    public void setFavorites(List<Favorite> favorites) { this.favorites = favorites; }
    public List<Share> getShares() { return shares; }
    public void setShares(List<Share> shares) { this.shares = shares; }
}