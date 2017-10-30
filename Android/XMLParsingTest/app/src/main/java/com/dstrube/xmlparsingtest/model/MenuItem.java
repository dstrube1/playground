package com.dstrube.xmlparsingtest.model;

public class MenuItem {
	//Not to be confused with android.view.MenuItem
	
	private String id;
	private String name;
	private String cost;
	private String description;

	public MenuItem() {
		setId("");
		setName("");
		setCost("");
		setDescription("");
	}

	public MenuItem(String id, String name, String cost, String description) {
		setId(id);
		setName(name);
		setCost(cost);
		setDescription(description);
	}

	public String getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public String getCost() {
		return cost;
	}

	public String getDescription() {
		return description;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setCost(String cost) {
		this.cost = cost;
	}

	public void setDescription(String description) {
		this.description = description;
	}

}
