// ActionScript file
//from : http://www.onflex.org/code/
package {
 import flash.display.Sprite;
 import flash.events.KeyboardEvent;
 import flash.text.TextField;
 import flash.text.TextFieldAutoSize;
 import flash.text.TextFormat;
 import flash.text.TextFormatAlign; 
 import flash.ui.Keyboard;
 
 public class Calendar extends Sprite {
  public var viewing:Date = null;
  public var cal:Sprite = null;  
  public var month:TextField = null;
  
  public function Calendar() {
   viewing = new Date();   
   cal = new Sprite();   
   
   // You can use left and right arrow keys to navigate the months
   stage.addEventListener( KeyboardEvent.KEY_DOWN, doNavigate );   
   
   initUI();
  }
  
  public function doNavigate( event:KeyboardEvent ):void {
   if( event.keyCode == Keyboard.RIGHT ) {
    viewing.month = viewing.month + 1;
   } else if( event.keyCode == Keyboard.LEFT ) {
    viewing.month = viewing.month - 1;
   }
   
   populate();
  }
  
  public function populate():void {
   var work:Date = new Date( viewing.time );
   var day:TextField = null;
   
   work.date = 1;
   
   while( work.day > 0 ) {
    work.date = work.date - 1;
   }
   
   for( var c:int = 0; c < cal.numChildren; c++ ) {
    day = TextField( cal.getChildAt( c ) );
    
    day.text = work.date.toString();
    
    if( work.month == viewing.month ) {
     day.textColor = 0x000000;
    } else {
     day.textColor = 0x808080;
    }
    
    work.date = work.date + 1;
   }    
   
   switch( viewing.month ) {
    case 0:
     month.text = "January ";
     break;
    case 1:
     month.text = "February ";
     break;
    case 2:
     month.text = "March ";
     break;
    case 3:
     month.text = "April ";
     break;
    case 4:
     month.text = "May ";
     break;
    case 5:
     month.text = "June ";
     break;
    case 6:
     month.text = "July ";
     break;
    case 7:
     month.text = "August ";
     break;
    case 8:
     month.text = "September ";
     break;
    case 9:
     month.text = "October ";
     break;
    case 10:
     month.text = "November ";
     break;                         
    case 11:
     month.text = "December ";
     break;                                                       
   }
   
   month.appendText( viewing.fullYear.toString() );
  }
  
  public function initUI():void {
   var day:TextField = null;   
   var format:TextFormat = new TextFormat( "Tahoma", 11, 0x000000 );

   format.align = TextFormatAlign.CENTER;

   month = new TextField();
   month.width = 119;
   month.height = 16;
   month.selectable = false;
   month.defaultTextFormat = format;

   addChild( month );

   graphics.lineStyle( 1, 0x808080 );
   graphics.moveTo( 0, month.height + 1 );
   graphics.lineTo( month.width, month.height + 1 );

   format.align = TextFormatAlign.RIGHT;   

   for( var w:int = 0; w < 6; w++ ) {
    for( var d:int = 0; d < 7; d++ ) {
     day = new TextField();

     day.selectable = false;
     day.defaultTextFormat = format;
     day.width = 17;
     day.height = 15;
     day.x = d * 17;
     day.y = w * 15;    
     cal.addChild( day );
    }
   }   

   cal.y = month.height + 2;
   addChild( cal );   
   
   populate();
  }
 }
}