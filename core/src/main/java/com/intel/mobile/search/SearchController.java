package com.intel.mobile.search;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SearchController {
    public SearchBeanList getSearchResults (String url, String q1, String q2, String q3, String q4) {
        return getSearchResults(url, q1, q2, q3, q4, "", "", "", "","","");
    }  
    public SearchBeanList getSearchResults (String url, String q1, String q2, String q3, String q4, String q10, String q11, String q23, String q24, String q26, String q40) {
        ISearchDAO searchDAO = new SearchDAOImpl();
        SearchBeanList searchBeanList = searchDAO.getResults(url, q1, q2, q3, q4,q10, q11, q23, q24, q26, q40);
        return searchBeanList;
    }
    
    public String getSearchCookies(HttpServletRequest req, HttpServletResponse res) {
       Cookie[] cookies = req.getCookies();
       String keywords = null;
       if (cookies != null) {
         for (int i = 0; i < cookies.length; i++) {
           if (cookies[i].getName().equals("searchkeywords")) {
             keywords = cookies[i].getValue();
             break;
           }
         }
       } else {
           return "";
       }
       return keywords!=null?keywords:"";
    }

    public void setSearchCookies(HttpServletRequest req, HttpServletResponse res, String searchterm){
       Cookie[] cookies = req.getCookies();
       String keywords = null;
       if (cookies != null) {
         for (int i = 0; i < cookies.length; i++) {
           if (cookies[i].getName().equals("searchkeywords")) {
             keywords = cookies[i].getValue();
             if (keywords != null && !keywords.isEmpty()) {
                keywords = keywords + ", "+ searchterm;
             } else {
                keywords = searchterm;
             }
             cookies[i].setValue(keywords);
             break;
           }
           if (keywords == null) {
              Cookie c = new Cookie("searchkeywords", searchterm);
              res.addCookie(c);
           }
         }
       }
    }
}