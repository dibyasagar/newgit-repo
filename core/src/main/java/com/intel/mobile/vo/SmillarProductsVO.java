package com.intel.mobile.vo;

public class SmillarProductsVO {
	
    private String name;
    private String picture;
    private String bestPrice;
	private String 	url;
	
	
	 public SmillarProductsVO  (String name,String picture,String bestPrice,String url)
	    {
	    	this.name = name;
	        this.picture = picture;
	        this.bestPrice = bestPrice;
	        this.url = url;
	        
	    }
	
	    public String getName() {
	        return name;
	       }
	       public void setName(String name) {
	        this.name = name;
	       }
	      
	    public String getPicture() {
		         return picture;
		        }
		        public void setPicture(String picture) {
		         this.picture = picture;
		        }
	    public String getBestPrice() {
			        return bestPrice;
			       }
			       public void setBestPrice(String bestPrice) {
			        this.bestPrice = bestPrice;
			       }     
	      public String getUrl() {
		         return url;
		    }
		    public void setUrl(String url) {
		        this.url = url;
		    }
	 
		    public boolean equals(Object prod) {
		    	boolean isEqual = false;
		    	if(prod instanceof SmillarProductsVO)
		    	{
		    		SmillarProductsVO prod1 = (SmillarProductsVO) prod;
		    		if(prod1.getName().equals(this.getName())){
		    			isEqual = true;
		    		}
		    	}
		    	return isEqual;
		    }
	
}
