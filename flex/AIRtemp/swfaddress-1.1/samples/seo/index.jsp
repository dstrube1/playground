<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.io.File,java.util.Date" %>
<%!

    // SEO helpers

    public String toTitleString(String str) {
        return (str.substring(0, 1).toUpperCase() + str.substring(1).toLowerCase());    
    }

    public String formatTitle(String addr) {

        String title = "SWFAddress SEO";
        if (addr != null) {
            int length = addr.length();
            title += ((length > 0) ? " / " + toTitleString(addr.substring(1, length - 1).replace("/", " / ")) : "");
        }
        return title;
    }

%>
<%

    // SEO variables
    
    String base = "/swfaddress/samples/seo";
    String swfaddress = request.getParameter("swfaddress");
    String title = formatTitle(swfaddress);
    String desc = "Atlantic Hit Mix Calendar";

    // Adds clienside redirect to fix IE support
    
    if (request.getHeader("User-Agent").toUpperCase().indexOf("MSIE") != -1 && request.getQueryString() != null) {
        out.println("<html><head><meta http-equiv=\"refresh\" content=\"0;url=" + base + "/#" + request.getQueryString() + "\" /></head></html>");
        return;
    }
    
    // Adds caching for dynamic content in order to support Refresh button in IE
    
    long ifModifiedSince = request.getDateHeader("If-Modified-Since");
    
    File file = new File(application.getRealPath(request.getServletPath()));
    long fileLastModified = file.lastModified();
    
    if(ifModifiedSince/1000 == fileLastModified/1000) {
        response.setStatus(HttpServletResponse.SC_NOT_MODIFIED);
        return;
    } 

    response.addDateHeader("Expires", new Date().getTime() + 86400000);
    response.addDateHeader("Last-Modified", fileLastModified);

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
    <head>
        <title><%= title %></title>
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <script type="text/javascript" src="<%= base %>/swfobject/swfobject.js"></script>        
        <script type="text/javascript" src="<%= base %>/swfaddress/swfaddress.js"></script>        
        <style type="text/css">
            /* hide from ie on mac \*/
            html {
                height: 100%;
                overflow: hidden;
            }

            #flashcontent {
                height: 100%;
            }
            /* end hide */

            body {
                height: 100%;
                margin: 0;
                padding: 0;
                background-color: #FFFFFF;
                font: 76% Arial, sans-serif;
            }
        </style>
    </head>
    <body>
        <div id="flashcontent">
            <h1><%= title %></h1>
            <ul>
                <li><a href="<%= base %>/">SWFAddress SEO</a></li>
                <li><a href="<%= base %>/about/">SWFAddress SEO / About</a></li>
                <li>
                    <a href="<%= base %>/portfolio/">SWFAddress SEO / Portfolio</a>
                    <ul>
                        <li><a href="<%= base %>/portfolio/1/?desc=true&amp;year=2001">SWFAddress SEO / Portfolio / 1</a></li>
                        <li><a href="<%= base %>/portfolio/2/?desc=true">SWFAddress SEO / Portfolio / 2</a></li>
                        <li><a href="<%= base %>/portfolio/3/?desc=false&amp;year=2001">SWFAddress SEO / Portfolio / 3</a></li>
                    </ul>
                </li>
                <li><a href="<%= base %>/contact/">SWFAddress SEO / Contact</a></li>
            </ul>
            <p>
            <% if (swfaddress == null) { %>
            
                Quisque libero mauris, ornare in, faucibus ut, facilisis nec, quam. Mauris quis felis ac nisl laoreet adipiscing. Nunc libero. Vivamus nec libero. Fusce neque odio, interdum a, pharetra sit amet, mattis non, nisl. Donec quis metus et pede gravida pharetra. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Sed tincidunt ipsum ut mi. Sed tincidunt porta ipsum. Curabitur sem risus, egestas et, ultricies sed, sollicitudin a, nulla. Praesent eget lectus sed erat commodo ultrices. Donec purus enim, nonummy ut, iaculis sit amet, convallis a, est. Mauris consequat, elit et scelerisque posuere, dui est convallis quam, vitae dignissim tortor odio consectetuer leo. Donec turpis velit, varius id, tincidunt sed, sodales id, eros.
            
            <% } else if ("/about/".equals(swfaddress)) { %>
            
                Suspendisse vitae nibh. Curabitur laoreet auctor velit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Etiam tortor. Sed porta diam vel augue. Praesent sollicitudin blandit lectus. Duis interdum, arcu vel convallis porttitor, magna tellus auctor odio, ac lobortis nulla orci vel lacus. Morbi tortor justo, sagittis et, interdum eget, placerat et, metus. Ut quis massa. Phasellus leo nulla, tempus sed, mattis mattis, sodales in, urna. Fusce in purus. Curabitur a lorem quis dolor ultrices egestas. Maecenas dolor elit, tincidunt vel, tempor ac, imperdiet a, quam. Nullam justo. Morbi sagittis. Ut suscipit pulvinar ante. Cras eu tortor. In nonummy, erat eget aliquet molestie, sapien eros pretium lorem, eu pretium urna neque eu purus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Pellentesque scelerisque lorem ut ligula.
            
            <% } else if ("/portfolio/".equals(swfaddress)) { %>
            
                Fusce at ipsum vel diam ullamcorper convallis. Morbi aliquet cursus lacus. Nunc nisi ligula, accumsan sit amet, condimentum nec, ullamcorper a, lectus. Vestibulum ut lectus. Ut rutrum mi nec lectus. Morbi quis nibh. Pellentesque congue, lorem quis porta tincidunt, tellus tortor venenatis leo, vel porttitor massa massa nec dui. In interdum euismod magna. In hac habitasse platea dictumst. Donec erat. Donec nunc ipsum, lobortis ac, feugiat sit amet, vehicula et, tellus. Donec in lacus ac metus condimentum gravida. Duis vehicula. In a neque in purus hendrerit molestie. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.
            
            <% } else if ("/portfolio/1/".equals(swfaddress)) { %>
            
                <img src="<%= base %>/images/1.png" alt="Portfolio 1" /><br />
                <%= ("true".equals(request.getParameter("desc"))) ? "<strong>" + desc + "</strong><br />" : "" %>
                <%= (request.getParameter("year") != null) ? "<strong>" + request.getParameter("year") + "</strong><br />" : "" %>
                <a href="http://www.lyubomirsergeev.com">Photos by Lyubomir Sergeev</a>
            
            <% } else if ("/portfolio/2/".equals(swfaddress)) { %>
            
                <img src="<%= base %>/images/2.png" alt="Portfolio 2" /><br />
                <%= ("true".equals(request.getParameter("desc"))) ? "<strong>" + desc + "</strong><br />" : "" %>
                <%= (request.getParameter("year") != null) ? "<strong>" + request.getParameter("year") + "</strong><br />" : "" %>
                <a href="http://www.lyubomirsergeev.com">Photos by Lyubomir Sergeev</a>
            
            <% } else if ("/portfolio/3/".equals(swfaddress)) { %>
            
                <img src="<%= base %>/images/3.png" alt="Portfolio 3" /><br />
                <%= ("true".equals(request.getParameter("desc"))) ? "<strong>" + desc + "</strong><br />" : "" %>
                <%= (request.getParameter("year") != null) ? "<strong>" + request.getParameter("year") + "</strong><br />" : "" %>
                <a href="http://www.lyubomirsergeev.com">Photos by Lyubomir Sergeev</a>
            
            <% } else if ("/contact/".equals(swfaddress)) { %>
            
                Nulla nec nunc id urna mollis molestie. Suspendisse potenti. Aliquam vitae dui. In semper ante eu massa. Praesent quis nunc. Vestibulum tristique tortor. Duis feugiat. Nam pharetra vulputate augue. Sed laoreet. Mauris id orci ac nisl consectetuer sollicitudin. Donec eu ante at velit cursus gravida. Suspendisse arcu.
            
            <% } %>
            </p>
        </div>
        <script type="text/javascript">
        // <![CDATA[
            var so = new SWFObject('<%= base %>/website.swf', 'website', '100%', '100%', '8', '#CCCCCC');
            so.useExpressInstall('<%= base %>/swfobject/expressinstall.swf');
            so.addParam('menu', 'false');            
            so.write('flashcontent');
        // ]]>
        </script>  
    </body>
</html>