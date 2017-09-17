package com.dstrube.payrange.model;

/**
 *
 */
public class VendingMachine {
    private int[] bleStrengths;
//    private String description;
    private int averageBleStrength;
//    private int imageId;

    public void setBleStrengths(final int[] strengths){
        bleStrengths = strengths;
        averageBleStrength = 0;
        for (int i : strengths){
            averageBleStrength += i;
        }
        averageBleStrength /= strengths.length;
    }

    public int[] getBleStrengths() {
        return bleStrengths;
    }

//    public void setDescription(String description) {
//        this.description = description;
//    }
//
//    public String getDescription() {
//        return description;
//    }

//No need for a set. This gets set when the strengths are set
//    public void setAverageBleStrength(int averageBleStrength) {
//        this.averageBleStrength = averageBleStrength;
//    }

    public int getAverageBleStrength() {
        return averageBleStrength;
    }

//    public void setImageId(int imageId) {
//        this.imageId = imageId;
//    }
//
//    public int getImageId() {
//        return imageId;
//    }
}
