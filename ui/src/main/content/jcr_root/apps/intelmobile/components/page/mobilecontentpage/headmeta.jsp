<%@page import="com.intel.mobile.util.ArticletUtil"%>
<%@ page session="false" %>
<%@include file="/libs/foundation/global.jsp" %>
<%@page import="com.intel.mobile.constants.IntelMobileConstants, com.intel.mobile.util.IntelUtil,com.intel.mobile.util.ProductUtil, java.util.Map, java.util.HashMap,com.day.cq.commons.Externalizer"%>
<%
	Map<String, String> metatags = new HashMap<String, String>();

	String templateName = currentPage.getProperties().get("cq:template","");
	String pageName = currentPage.getName();
	
	if(templateName.endsWith("/productdetails") || templateName.endsWith("/productdetailscms")) {
		/* Tags for Product Pages (SHOP and CMS)*/
		metatags = ProductUtil.getProductMetaTags(resourceResolver,currentPage);	
		metatags.put("format-detection","telephone=no");
	} else if(templateName.endsWith("/article")) {
		/* Tags for Article Pages */
		metatags = ArticletUtil.getArticleMetaTags(resourceResolver,currentPage);
	}
		
	/* Language Specific Tag */
	String locale = IntelUtil.getLocale(currentPage);
	if(locale != null && locale.length()>0) {
		metatags.put(IntelMobileConstants.META_TAG_LOCALE_CODE, locale);
	}
	
	/* Published Date Tag */
	String publishedDate = currentPage.getProperties().get("cq:lastReplicated","");
	if(publishedDate.length()>0) {
		if(publishedDate.length()>=19) publishedDate = publishedDate.substring(0,19)+"Z"; 
		metatags.put(IntelMobileConstants.META_TAG_LAST_MODIFIED_DATE,publishedDate);
	}
		
	
	
	/* Open Graph Tags */
	String ogtitle = properties.get("ogtitle","");
	if(ogtitle.length()==0) {
		ogtitle = currentPage.getTitle();
	}
	
	String ogurl = properties.get("ogurl","");
	if(ogurl.length()==0) {
		ogurl = resourceResolver.map(currentPage.getPath()) + ".html";
		ogurl = request.getScheme() + "://" + request.getServerName() + ogurl;
	}

	String ogtype = properties.get("ogtype","");
	if(ogtype.length()==0) {
		ogtype = "company";
	}
	
	String ogdescription = properties.get("ogdescription","");
	if(currentPage.getDescription() != null && currentPage.getDescription().length() > 0 ) {
		ogdescription = currentPage.getDescription();
	}
	
	if(templateName.endsWith("/productlisting")) {
		pageContext.setAttribute("nocrawl","yes");
	}
	
	pageContext.setAttribute("pagename",pageName);
	pageContext.setAttribute("ogtitle", ogtitle);
	pageContext.setAttribute("ogurl", ogurl);
	pageContext.setAttribute("ogtype", ogtype);
	pageContext.setAttribute("ogdescription", ogdescription);
	
	pageContext.setAttribute("ogdescription", ogdescription);
	
	pageContext.setAttribute("gsv", IntelUtil.getGoogleSiteVerificationCode(currentPage));
	pageContext.setAttribute("metatags", metatags);
	
	 final Externalizer externalizer = resourceResolver.adaptTo(Externalizer.class);
	 final String canonicalURL  = externalizer.absoluteLink(slingRequest, "http", properties.get("ogimage",""));
	
%>
<c:if test="${properties.fbadmins ne null and properties.fbadmins ne '' }">
	<meta property="fb:admins" content="${properties.fbadmins}" />
</c:if>

<c:if test="${properties.fbappid ne null and properties.fbappid ne '' }">
	<meta property="fb:app_id" content="${properties.fbappid}" />
</c:if>
        
<c:if test="${ogtitle ne null and ogtitle ne '' }">
	<meta property="og:title" content="${ogtitle}" />
</c:if>

<c:if test="${ogtype ne null and ogtype ne '' }">
	<meta property="og:type" content="${ogtype}" />
</c:if>

<c:if test="${ogurl ne null and ogurl ne '' }">
	<meta property="og:url" content="${ogurl}" />
</c:if>

<c:if test="${properties.ogimage ne null and properties.ogimage ne '' }">
	<meta property="og:image" content="<%= xssAPI.getValidHref(canonicalURL) %>"/>
</c:if>

<meta property="og:site_name" content="Intel-Mobile" />

<c:if test="${ogdescription ne null and ogdescription ne '' }">
	<meta property="og:description" content="${ogdescription}" />
	<meta property="description" content="${ogdescription}" />
</c:if>



<c:forEach var="entry" items="${metatags}">
	<meta name="${entry.key}" content="${entry.value}" />
</c:forEach>

<c:if test="${gsv ne null and gsv ne '' }">
	<meta name="google-site-verification" content="${gsv}" />
</c:if>

<c:if test="${nocrawl eq 'yes' or pagename eq 'search-result'}">
	<META NAME="ROBOTS" CONTENT="NOINDEX, NOFOLLOW">
</c:if>
