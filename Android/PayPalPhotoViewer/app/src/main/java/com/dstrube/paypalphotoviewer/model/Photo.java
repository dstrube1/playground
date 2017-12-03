package com.dstrube.paypalphotoviewer.model;

/**
 * This class represents a PayPal photo object
 * @author david.strube
 *
 */
public class Photo {
    /**
     * Parameterless Constructor
     */
    public Photo() {
    }

    private String name;
    private String path;
    private String location;
    private String lat;
    private String lng;
    private String dateTaken;

    /**
     * Parameterful Constructor
     *
     * @param name
     * @param path
     * @param location
     * @param lat
     * @param lng
     * @param dateTaken
     */
    public Photo(String name, String path, String location, String lat,
                 String lng, String dateTaken) {
        this.name = name;
        this.path = path;
        this.location = location;
        this.lat = lat;
        this.lng = lng;
        this.dateTaken = dateTaken;
    }

    /**
     * Get the name
     * @return name
     */
    public String getName() {
        return name;
    }

    /**
     * Get the path
     * @return path
     */
    public String getPath() {
        return path;
    }

    /**
     * Get the location
     * @return location
     */
    public String getLocation() {
        return location;
    }

    /**
     * Get the latitude
     * @return latitude
     */
    public String getLat() {
        return lat;
    }

    /**
     * Get the longitude
     * @return longitude
     */
    public String getLng() {
        return lng;
    }

    /**
     * Get the date taken
     * @return date taken
     */
    public String getDateTaken() {
        return dateTaken;
    }

    /**
     * Set the name
     * @param name
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Set the path
     * @param path
     */
    public void setPath(String path) {
        this.path = path;
    }

    /**
     * Set the location
     * @param location
     */
    public void setLocation(String location) {
        this.location = location;
    }

    /**
     * Set the latitude
     * @param lat
     */
    public void setLat(String lat) {
        this.lat = lat;
    }

    /**
     * Set the longitude
     * @param lng
     */
    public void setLng(String lng) {
        this.lng = lng;
    }

    /**
     * Set the date taken
     * @param dateTaken date taken
     */
    public void setDateTaken(String dateTaken) {
        this.dateTaken = dateTaken;
    }
}
