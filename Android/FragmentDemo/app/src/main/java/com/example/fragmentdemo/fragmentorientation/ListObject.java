package com.example.fragmentdemo.fragmentorientation;

public class ListObject {
    private String name;
    private String description;

    public ListObject() {
        name = "";
        description = "";
    }

    public ListObject(String name, String description) {
        setName(name );
        setDescription(description);
    }

    public String getName() {
        return name;
    }

    public String getDescription() {
        return description;
    }

    public void setName(String name) {
        this.name = name;
    }
    public void setDescription(String description) {
        this.description = description;
    }

}
