package com.intel.mobile.search;

import java.util.Collection;

public class SearchBeanList {
    private int totalCount;
    private boolean status;
    private Collection<SearchBean> searchBeans;
    private String errorCode;
    private String errorMessage;
    private String didYouMessage;

    public int getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Collection<SearchBean> getSearchBeans() {
        return searchBeans;
    }

    public void setSearchBeans(Collection<SearchBean> searchBeans) {
        this.searchBeans = searchBeans;
    }

    public String getErrorCode() {
        return errorCode;
    }

    public void setErrorCode(String errorCode) {
        this.errorCode = errorCode;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }
    public String getDidYouMessage() {
        return didYouMessage;
    }

    public void setDidYouMessage(String didYouMessage) {
        this.didYouMessage = didYouMessage;
    }
}
