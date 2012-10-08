package com.intel.mobile.vo;

public class ProductDetailsVo {

		    private String name;
            private String price;
		    private String processor;
		    private String hardDrive;
		    private String ram;
		    private String image;
		    private String id;
		    private String manufacturer;
		    private String formFactor;
		    
		    public ProductDetailsVo (String name,String price,String processor,String hardDrive,String ram,String image,String id)
		    {
		        this.name = name;
		         this.price = price;
		         this.processor = processor;
		         this.hardDrive = hardDrive;
		         this.ram= ram;
		         this.image = image;
		         this.id = id;
		    }

		        public ProductDetailsVo() {
				// TODO Auto-generated constructor stub
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
		        
		        public String getProcessor() {
		         return processor;
		        }
		        public void setProcessor(String processor) {
		         this.processor = processor;
		        }
		        public String getHardDrive() {
			         return hardDrive;
			    }
			    public void setHardDrive(String hardDrive) {
			        this.hardDrive = hardDrive;
			    }
		        public String getRam() {
			         return ram;
			    }
			    public void setRam(String ram) {
			        this.ram = ram;
			    }
			    public String getImage() {
			         return image;
			    }
			    public void setImage(String image) {
			        this.image = image;
			    }
			    public String getId() {
			         return id;
			    }
			    public void setId(String id) {
			        this.id = id;
			    }

				@Override
				public String toString() {
					
					StringBuffer strBuffer = new StringBuffer();
					strBuffer.append("Name : ").append(getName()).append(" , ");
					strBuffer.append("Price : ").append(getPrice()).append(" , ");
					strBuffer.append("Processor : ").append(getProcessor()).append(" , ");
					strBuffer.append("hard Drive : ").append(getHardDrive()).append(" , ");
					strBuffer.append("RAM : ").append(getRam()).append(" , ");
					strBuffer.append("Image : ").append(getImage());
					
					return strBuffer.toString();
				}

				public String getManufacturer() {
					return manufacturer;
				}

				public void setManufacturer(String manufacturer) {
					this.manufacturer = manufacturer;
				}

				public String getFormFactor() {
					return formFactor;
				}

				public void setFormFactor(String formFactor) {
					this.formFactor = formFactor;
				}
			    
			    

}
