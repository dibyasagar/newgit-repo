/**
 * 
 */
package com.intel.mobile.vo;

/**
 * @author skarm1
 *
 */
public class ProductSubFilterVO {

	private String subFilterName ;
	private String subFilterValue ;
	public String getSubFilterName() {
		return subFilterName;
	}
	public void setSubFilterName(String subFilterName) {
		this.subFilterName = subFilterName;
	}
	public String getSubFilterValue() {
		return subFilterValue;
	}
	public void setSubFilterValue(String subFilterValue) {
		this.subFilterValue = subFilterValue;
	}
	@Override
	public String toString() {
		StringBuffer str = new StringBuffer();
		str.append("Sub Filter Name :"+this.subFilterName).append(" , ").append("Sub Filter Value :").append(this.subFilterValue);
		return super.toString();
	}
	
	
}
