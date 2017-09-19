package com.dstrube.paypalphotoviewer.view;

public class PhotoRowObject {
	private String path;
	private boolean isLocal;
	
	public PhotoRowObject(){
		path="";
		isLocal = true;
	}
	public PhotoRowObject(String path, boolean isLocal){
		this.path = path;
		this.isLocal = isLocal;
	}
	
	public String getPath(){
		return path;
	}
	public boolean getIsLocal(){
		return isLocal;
	}
	public void setPath(String path){
		this.path = path;
	}
	public void setIsLocal(boolean isLocal){
		this.isLocal = isLocal;
	}
}
