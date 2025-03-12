/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author Nhat Anh
 */
public class Image {

    
    private int ImageID;
    private String ImagePath;
    private String ImageType;

    public Image() {
    }
    public Image(int ImageID, String ImagePath,String ImageType) {
        this.ImageID = ImageID;
        this.ImagePath = ImagePath;
        this.ImageType = ImageType;
    }

    public Image(int ImageID, String ImagePath) {
        this.ImageID = ImageID;
        this.ImagePath = ImagePath;
    }

    // Getters & Setters
    public int getImageID() {
        return ImageID;
    }

    public void setImageID(int ImageID) {
        this.ImageID = ImageID;
    }

    public String getImagePath() {
        return ImagePath;
    }

    public String getImageType() {
        return ImageType;
    }

    public void setImagePath(String ImagePath) {
        this.ImagePath = ImagePath;
    }

    public void setImageType(String ImageType) {
        this.ImageType = ImageType;
    }

    
}


