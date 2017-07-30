package com.dstrube.weblistintent.model;

public class LinkData {
	private String domain;
    private String url;
    
    public LinkData(String domain, String url) {
            this.domain = domain;
            this.url = url;
    }
    
    public String getDomain() {
            return domain;
    }
    public void setDomain(String domain) {
            this.domain = domain;
    }
    public String getUrl() {
            return url;
    }
    public void setUrl(String url) {
            this.url = url;
    }
}
