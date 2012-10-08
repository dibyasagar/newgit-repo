/**
 * 
 */
package com.intel.mobile.vo;

/**
 * @author skarm1
 *
 */
public class UltrabookMenuItemVO {

	private String name;
	private String imagePath;
	private String cellId;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getImagePath() {
		return imagePath;
	}
	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
	public String getCellId() {
		return cellId;
	}
	public void setCellId(String cellId) {
		this.cellId = cellId;
	}
	@Override
	public String toString() {
		
		StringBuffer stringBuffer = new StringBuffer();
		stringBuffer.append(this.name).append(" | ").append(this.cellId).append(" | ").append(this.imagePath);
		
		return stringBuffer.toString();
	}

	


}
