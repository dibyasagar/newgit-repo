package com.intel.mobile.util;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

import org.apache.commons.lang.StringEscapeUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.day.cq.wcm.api.Page;
import com.day.cq.wcm.api.PageFilter;

public class IntelSitemap
{
	private static final Logger LOGGER = LoggerFactory.getLogger(ProductUtil.class);
    public class Link
    {

        public String getPath()
        {
            return path;
        }

        public int getLevel()
        {
            return level;
        }

        public String getTitle()
        {
            return title;
        }

        private String path;
        private String title;
        private int level;
        final IntelSitemap this$0;

        public Link(String path, String title, int level)
        {
            super();
        	this$0 = IntelSitemap.this;
            this.path = path;
            this.title = title;
            this.level = level;
        }
    }


    public IntelSitemap(Page rootPage, List exceptionPaths)
    {
        links = new LinkedList();
        this.exceptionPaths = exceptionPaths;
        buildLinkAndChildren(rootPage, 0);
    }

    private void buildLinkAndChildren(Page page, int level)
    {
        if(page != null)
        {
            String title = page.getTitle();
            if(title == null)
                title = page.getName();
            if(exceptionPaths == null || exceptionPaths.size()==0) {
            	links.add(new Link(page.getPath(), title, level));	
            } else if(!exceptionPaths.contains(page.getPath())) {
            	links.add(new Link(page.getPath(), title, level));
            } else {
            }
            Page child;
            for(Iterator children = page.listChildren(new PageFilter()); children.hasNext(); buildLinkAndChildren(child, level + 1))
                child = (Page)children.next();

        }
    }

    public void draw(Writer w)
        throws IOException
    {
        PrintWriter out = new PrintWriter(w);
        int previousLevel = -1;
        for(Iterator i$ = links.iterator(); i$.hasNext();)
        {
            Link aLink = (Link)i$.next();
            if(aLink.getLevel() > previousLevel)
                out.print("<div class=\"linkcontainer\">");
            else
            if(aLink.getLevel() < previousLevel)
            {
                for(int i = aLink.getLevel(); i < previousLevel; i++)
                    out.print("</div>");

            }
            out.printf("<div class=\"link\"><a href=\"%s.touch.html\">%s</a></div>", new Object[] {
                StringEscapeUtils.escapeHtml(aLink.getPath()), aLink.getTitle()
            });
            previousLevel = aLink.getLevel();
        }

        for(int i = -1; i < previousLevel; i++)
            out.print("</div>");

    }

    public LinkedList getLinks()
    {
        return links;
    }

    private LinkedList links;
    private List exceptionPaths;
}
