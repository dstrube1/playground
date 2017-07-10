<?

    header('Content-Type: text/html; charset=utf-8');    
    
    // SEO helpers

    function strtotitle($str) {
        return strtoupper(substr($str, 0, 1)) . strtolower(substr($str, 1));
    }

    function format_title($addr) {
        $title = 'SWFAddress SEO';
        if ($addr != '') {
            $length = strlen($addr);
            $title .= (($length > 0) ? ' / ' . strtotitle(str_replace('/', ' / ', substr($addr, 1, $length - 2))) : '');
        }
        return $title;        
    }
    
    // SEO variables
    
    $base = '/swfaddress/samples/seo';
    $swfaddress = $_GET['swfaddress'];
    $title = format_title($swfaddress);
    $desc = 'Atlantic Hit Mix Calendar <br />';
       
    // Adds clienside redirect to fix IE support
    
    if (strstr(strtoupper($_SERVER['HTTP_USER_AGENT']), 'MSIE') && !empty($_SERVER['QUERY_STRING'])) {
        echo('<html><head><meta http-equiv="refresh" content="0;url=' . $base . '/#' . $_SERVER['QUERY_STRING'] . '" /></head></html>');
        exit();
    }

    // Adds caching for dynamic content in order to support Refresh button in IE
    
    $if_modified_since = preg_replace('/;.*$/', '', $_SERVER['HTTP_IF_MODIFIED_SINCE']);
    
    $file_last_modified = filemtime($_SERVER['PATH_TRANSLATED']);
    $gmdate_modified = gmdate('D, d M Y H:i:s', $file_last_modified) . ' GMT';

    if ($if_modified_since == $gmdate_modified) {
        if (php_sapi_name()=='cgi') {
            header('Status: 304 Not Modified');
        } else {
            header('HTTP/1.1 304 Not Modified');
        }
        exit();
    }
    
    header('Expires: ' . gmdate('D, d M Y H:i:s', time() + 86400) . ' GMT');
    header('Last-Modified: ' . $gmdate_modified);
    
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
    <head>
    <title><?= $title ?></title>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <script type="text/javascript" src="<?= $base ?>/swfobject/swfobject.js"></script>        
    <script type="text/javascript" src="<?= $base ?>/swfaddress/swfaddress.js"></script>        
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
            <h1><?= $title ?></h1>
            <ul>
                <li><a href="<?= $base ?>/">SWFAddress SEO</a></li>
                <li><a href="<?= $base ?>/about/">SWFAddress SEO / About</a></li>
                <li>
                    <a href="<?= $base ?>/portfolio/">SWFAddress Website / Portfolio</a>
                    <ul>
                        <li><a href="<?= $base ?>/portfolio/1/?desc=true&amp;year=2001">SWFAddress SEO / Portfolio / 1</a></li>
                        <li><a href="<?= $base ?>/portfolio/2/?desc=true">SWFAddress SEO / Portfolio / 2</a></li>
                        <li><a href="<?= $base ?>/portfolio/3/?desc=false&amp;year=2001">SWFAddress SEO / Portfolio / 3</a></li>
                    </ul>
                </li>
                <li><a href="<?= $base ?>/contact/">SWFAddress SEO / Contact</a></li>
            </ul>
            <p>
<? switch($swfaddress) {
    case '': 
?>
                Quisque libero mauris, ornare in, faucibus ut, facilisis nec, quam. Mauris quis felis ac nisl laoreet adipiscing. Nunc libero. Vivamus nec libero. Fusce neque odio, interdum a, pharetra sit amet, mattis non, nisl. Donec quis metus et pede gravida pharetra. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Sed tincidunt ipsum ut mi. Sed tincidunt porta ipsum. Curabitur sem risus, egestas et, ultricies sed, sollicitudin a, nulla. Praesent eget lectus sed erat commodo ultrices. Donec purus enim, nonummy ut, iaculis sit amet, convallis a, est. Mauris consequat, elit et scelerisque posuere, dui est convallis quam, vitae dignissim tortor odio consectetuer leo. Donec turpis velit, varius id, tincidunt sed, sodales id, eros.
<?  break;
    case '/about/': 
?>
                Suspendisse vitae nibh. Curabitur laoreet auctor velit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Etiam tortor. Sed porta diam vel augue. Praesent sollicitudin blandit lectus. Duis interdum, arcu vel convallis porttitor, magna tellus auctor odio, ac lobortis nulla orci vel lacus. Morbi tortor justo, sagittis et, interdum eget, placerat et, metus. Ut quis massa. Phasellus leo nulla, tempus sed, mattis mattis, sodales in, urna. Fusce in purus. Curabitur a lorem quis dolor ultrices egestas. Maecenas dolor elit, tincidunt vel, tempor ac, imperdiet a, quam. Nullam justo. Morbi sagittis. Ut suscipit pulvinar ante. Cras eu tortor. In nonummy, erat eget aliquet molestie, sapien eros pretium lorem, eu pretium urna neque eu purus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos hymenaeos. Pellentesque scelerisque lorem ut ligula.
<?  break;
    case '/portfolio/':
?>
                Fusce at ipsum vel diam ullamcorper convallis. Morbi aliquet cursus lacus. Nunc nisi ligula, accumsan sit amet, condimentum nec, ullamcorper a, lectus. Vestibulum ut lectus. Ut rutrum mi nec lectus. Morbi quis nibh. Pellentesque congue, lorem quis porta tincidunt, tellus tortor venenatis leo, vel porttitor massa massa nec dui. In interdum euismod magna. In hac habitasse platea dictumst. Donec erat. Donec nunc ipsum, lobortis ac, feugiat sit amet, vehicula et, tellus. Donec in lacus ac metus condimentum gravida. Duis vehicula. In a neque in purus hendrerit molestie. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.
<?  break;
    case '/portfolio/1/':
?>
                <img src="<?= $base ?>/images/1.png" alt="Portfolio 1" /><br />
                <?= ($_GET['desc'] == 'true') ? '<strong>' . $desc . '</strong><br />' : '' ?>
                <?= (isset($_GET['year'])) ? '<strong>' . $_GET['year'] . '</strong><br />' : '' ?>
                <a href="http://www.lyubomirsergeev.com">Photos by Lyubomir Sergeev</a>
<?  break;
    case '/portfolio/2/':
?>
                <img src="<?= $base ?>/images/2.png" alt="Portfolio 2" /><br />
                <?= ($_GET['desc'] == 'true') ? '<strong>' . $desc . '</strong><br />' : '' ?>
                <?= (isset($_GET['year'])) ? '<strong>' . $_GET['year'] . '</strong><br />' : '' ?>
                <a href="http://www.lyubomirsergeev.com">Photos by Lyubomir Sergeev</a>
<?  break;
    case '/portfolio/3/':
?>
                <img src="<?= $base ?>/images/3.png" alt="Portfolio 3" /><br />
                <?= ($_GET['desc'] == 'true') ? '<strong>' . $desc . '</strong><br />' : '' ?>
                <?= (isset($_GET['year'])) ? '<strong>' . $_GET['year'] . '</strong><br />' : '' ?>
                <a href="http://www.lyubomirsergeev.com">Photos by Lyubomir Sergeev</a>
<?  break;
    case '/contact/':
?>
                Nulla nec nunc id urna mollis molestie. Suspendisse potenti. Aliquam vitae dui. In semper ante eu massa. Praesent quis nunc. Vestibulum tristique tortor. Duis feugiat. Nam pharetra vulputate augue. Sed laoreet. Mauris id orci ac nisl consectetuer sollicitudin. Donec eu ante at velit cursus gravida. Suspendisse arcu.
<?  break;
 }
?>
            </p>        
        </div>
        <script type="text/javascript">
        // <![CDATA[
            var so = new SWFObject('<?= $base ?>/website.swf', 'website', '100%', '100%', '8', '#CCCCCC');
            so.useExpressInstall('<?= $base ?>/swfobject/expressinstall.swf');
            so.addParam('menu', 'false');            
            so.write('flashcontent');
        // ]]>
        </script>        
    </body>
</html>
