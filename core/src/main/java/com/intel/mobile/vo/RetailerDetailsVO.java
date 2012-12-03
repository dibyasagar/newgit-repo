package com.intel.mobile.vo;

public class RetailerDetailsVO {
	
	private String logo;
	private String name;
    private String price;
    private String url;
   
    public RetailerDetailsVO (String logo,String name,String price,String url)
    {
    	this.logo = logo;
        this.name = name;
        this.price = price;
        this.url = url;
        
    }
    public String getLogo() {
        return logo;
       }
       public void setLogo(String logo) {
        this.logo = logo;
       }
    public String getName() {
        return name;
       }
       public void setName(String name) {
        this.name = name;
       }
      
       public String getPrice() {
	         return price;
	        }
	        public void setPrice(String price) {
	         this.price = price;
	        }
       
       
       public String getUrl() {
	         return url;
	    }
	    public void setUrl(String url) {
	        this.url = url;
	    }
    

}
