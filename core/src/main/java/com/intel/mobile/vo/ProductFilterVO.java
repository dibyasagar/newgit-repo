package com.intel.mobile.vo;

import java.util.List;

/**
 * 
 * @author smukh5
 *
 */

public class ProductFilterVO {
	
	private String filterName ;
	private List<ProductSubFilterVO> subFilters ;

	public ProductFilterVO (){
		
		filterName = "" ;
		
	}
	
	
	public String getFilterName (){
		
		return filterName ;
		
	}
	
	public void setFilterName(String pStrFilterName ){
		
		this.filterName = pStrFilterName ;
		
	}




	@Override
	public String toString() {
		
		StringBuffer stringBuffer = new StringBuffer();
		stringBuffer.append("Filter Name : ").append(this.filterName).append(" , ");
		stringBuffer.append("Sub Filters : ").append(this.subFilters);
		return stringBuffer.toString();
	}


	public List<ProductSubFilterVO> getSubFilters() {
		return subFilters;
	}


	public void setSubFilters(List<ProductSubFilterVO> subFilters) {
		this.subFilters = subFilters;
	}
	
	
	
	
}