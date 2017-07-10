class Website {

    private var _mc:MovieClip;
    
    public function Website(mc:MovieClip) {

        _mc = mc;
        
        Stage.scaleMode = 'noScale';
        Stage.align = 'T';
        
        _mc.beginFill(0xFFFFFF);
        drawRect(_mc, 0, 0, 480, 2480);
        _mc.endFill();
        
        var content_fmt:TextFormat = new TextFormat();
        content_fmt.font = 'Arial';
        content_fmt.bold = true;
        content_fmt.size = 24;
        content_fmt.color = 0x666666;            
        
        var content_txt = _mc.createTextField('content_txt', 1, 38, 20, 20, 20);
        content_txt.autoSize = 'left';
        content_txt.selectable = false;            
        content_txt.antiAliasType = 'advanced';
        content_txt.setNewTextFormat(content_fmt);
        content_txt.text = 'SWFAddress Website';
        
        var home_mc = drawButton(_mc, 'HOME');
        home_mc._x = 40;
        home_mc._y = 60;
        home_mc.onRelease = function() {
            SWFAddress.setValue('');
        }
        
        var about_mc = drawButton(_mc, 'ABOUT');
        about_mc._x = home_mc._x + home_mc._width + 2;
        about_mc._y = 60;
        about_mc.onRelease = function() {
            SWFAddress.setValue('/about/');
        }
        
        var contact_mc = drawButton(_mc, 'CONTACT');
        contact_mc._x = about_mc._x + about_mc._width + 2;
        contact_mc._y = 60;
        contact_mc.onRelease = function() {
            SWFAddress.setValue('/contact/');
        }

        SWFAddress.onChange = function() {
            var addr:String = SWFAddress.getValue();
            mc.home_mc.content_txt.textColor = (addr == '') ? 0xCCCCCC : 0xFFFFFF;
            mc.about_mc.content_txt.textColor = (addr == '/about/') ? 0xCCCCCC : 0xFFFFFF;
            mc.contact_mc.content_txt.textColor = (addr == '/contact/') ? 0xCCCCCC : 0xFFFFFF;
            SWFAddress.setTitle(Website.formatTitle(addr));
        }
    }

    public static function drawButton(mc:MovieClip, label:String):Void {

        var button_mc = mc.createEmptyMovieClip(label.toLowerCase() + '_mc', mc.getNextHighestDepth());

        var content_fmt:TextFormat = new TextFormat();
        content_fmt.font = 'Arial';
        content_fmt.bold = true;
        content_fmt.size = 14;
        
        var content_txt = button_mc.createTextField('content_txt', 0, 10, 0, 60, 20);
        content_txt.autoSize = 'left';
        content_txt.selectable = false;            
        content_txt.antiAliasType = 'advanced';
        content_txt.setNewTextFormat(content_fmt);
        content_txt.text = label;
        content_txt.textColor = 0xFFFFFF;
       
        button_mc.beginFill(0x000000);
        drawRect(button_mc, 0, 0, content_txt._width + 20, content_txt._height);
        button_mc.endFill();
        
        return button_mc;       
    }
    
    public static function drawRect(mc:MovieClip, x:Number, y:Number, w:Number, h:Number):Void {
        mc.moveTo(x, y);
        mc.lineTo(x + w, y);
        mc.lineTo(x + w, y + h);
        mc.lineTo(x, y + h);
        mc.lineTo(x, y);
    }

    public static function replace(str:String, find:String, replace:String):String {
        return str.split(find).join(replace);
    }

    public static function toTitleCase(str:String):String {
        return str.substr(0,1).toUpperCase() + str.substr(1).toLowerCase();
    }

    public static function formatTitle(addr:String):String {
        return 'SWFAddress Website' + ((addr.length > 1) ? ' » ' + toTitleCase(replace(addr.substring(1, addr.length - 1), '/', ' / ')) : '');
    }

    public static function main():Void {
        _root.onEnterFrame = function() {
            var bl:Number = this.getBytesLoaded();
            var bt:Number = this.getBytesTotal();
            if (bl && bt && bl == bt) {
                var website:Website = new Website(_root);
                delete this.onEnterFrame;
            }
        }        
    }
}