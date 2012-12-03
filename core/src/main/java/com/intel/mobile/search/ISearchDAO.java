package com.intel.mobile.search;

public interface ISearchDAO {
    abstract SearchBeanList getResults (String url, String q1, String q2, String q3, String q4, String q10, String q11, String q23, String q24, String q26, String q40);
}
