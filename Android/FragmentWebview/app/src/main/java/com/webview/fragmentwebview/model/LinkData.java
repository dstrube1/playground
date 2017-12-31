package com.webview.fragmentwebview.model;

public class LinkData {

        private String name;
        private String link;
        
        public LinkData(String name, String link) {
                this.name = name;
                this.link = link;
        }
        
        public String getName() {
                return name;
        }
        public void setName(String name) {
                this.name = name;
        }
        public String getLink() {
                return link;
        }
        public void setLink(String link) {
                this.link = link;
        }
        
        
}