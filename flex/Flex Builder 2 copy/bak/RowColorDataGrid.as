// ActionScript file
package
{
    import mx.controls.DataGrid;
    import flash.display.Sprite;
    import flash.display.Shape;
    import flash.display.Graphics;
    import mx.core.FlexSprite;
    import mx.core.FlexShape;
    import mx.styles.StyleManager;
    import mx.utils.ArrayUtil;    

/**
 *  An array that contains styleNames for each rowColor
 */
[Style(name="rowColors", type="Array", inherit="no")]

    public class RowColorDataGrid extends DataGrid
    {        
        private var _rowColors:Array = new Array;
    
        public function get rowColors():Array {
            return _rowColors;
        }
        
        public function set rowColors(value:Array):void {
            _rowColors = value;
        }
            
        override protected function drawRowBackgrounds():void
        {                    
            var rowBGs:Sprite = Sprite(listContent.getChildByName("rowBGs"));
            if (!rowBGs)
            {
                rowBGs = new FlexSprite();
                rowBGs.mouseEnabled = false;
                rowBGs.name = "rowBGs";
                listContent.addChildAt(rowBGs, 0);
            }

            var colors:Array;
    
            colors = getStyle("alternatingItemColors");
    
            if (!colors || colors.length == 0)
                return;
    
            StyleManager.getColorNames(colors);
    
            var curRow:int = 0;
            if (showHeaders)
                curRow++;
    
            var i:int = 0;
            var actualRow:int = verticalScrollPosition;
            var n:int = listItems.length;
            var curCol:int = 0;
            
            var rc:int = 0;
            var rowColorCriteria:RowColorCriteria = new RowColorCriteria;     
            var rowBackgroundColor:uint = new uint;
            var cellValue:Object = new Object;
    
            // loop through rows        
            while (curRow < n)
            {  
                rowBackgroundColor = colors[actualRow % colors.length];
                
                if (rowColors.length == 0 && styleName)
                {
                    rowColors = mx.utils.ArrayUtil.toArray(StyleManager.getStyleDeclaration("."+styleName).getStyle("rowColors"));
                }
                
                if (rowColors.length != 0 && columnCount != 0)
                {          
                    // loop backwards through rowColors for priority order
                    for (rc = rowColors.length-1; rc >= 0; rc--)
                    {
                        rowColorCriteria.dataField = StyleManager.getStyleDeclaration("."+rowColors[rc]).getStyle("dataField");
                        rowColorCriteria.condition = StyleManager.getStyleDeclaration("."+rowColors[rc]).getStyle("condition");
                        rowColorCriteria.value = StyleManager.getStyleDeclaration("."+rowColors[rc]).getStyle("value");
                        rowColorCriteria.backgroundColor = StyleManager.getColorName(StyleManager.getStyleDeclaration("."+rowColors[rc]).getStyle("backgroundColor"));                
                        
                        // loop through columns
                        for (curCol = 0; curCol < columnCount; curCol++) 
                        {    
                            if (actualRow < dataProvider.length)
                            {
                                cellValue = dataProvider.getItemAt(actualRow)[rowColorCriteria.dataField];
                             
                                 // match condition && value for custom row colors
                                switch (rowColorCriteria.condition.toLowerCase())
                                {
                                    case "eq" :
                                        rowBackgroundColor = (cellValue == rowColorCriteria.value 
                                        ? rowColorCriteria.backgroundColor : rowBackgroundColor);
                                        break;
                                    case "ne" :
                                        rowBackgroundColor = (cellValue != rowColorCriteria.value 
                                        ? rowColorCriteria.backgroundColor : rowBackgroundColor);
                                        break;
                                    case "lt" : 
                                        rowBackgroundColor = (cellValue < rowColorCriteria.value 
                                        ? rowColorCriteria.backgroundColor : rowBackgroundColor);
                                        break;
                                    case "gt" :
                                        rowBackgroundColor = (cellValue > rowColorCriteria.value 
                                        ? rowColorCriteria.backgroundColor : rowBackgroundColor);
                                        break;
                                    case "le" :
                                        rowBackgroundColor = (cellValue <= rowColorCriteria.value 
                                        ? rowColorCriteria.backgroundColor : rowBackgroundColor);
                                        break;
                                    case "ge" :
                                        rowBackgroundColor = (cellValue >= rowColorCriteria.value 
                                        ? rowColorCriteria.backgroundColor : rowBackgroundColor);
                                        break;
                                    default :
                                        break;
                                                                         
                                } // condition && value          
                            } // dataField 
                        } // columns
                    } // rowColors 
                }// rows
                
                drawRowBackground(rowBGs, i++, rowInfo[curRow].y, rowInfo[curRow].height, rowBackgroundColor, actualRow);
                
                curRow++;
                actualRow++;
            }
    
            while (rowBGs.numChildren > i)
            {
                rowBGs.removeChildAt(rowBGs.numChildren - 1);
            }
            super.invalidateDisplayList();
        }    
    }
}

class RowColorCriteria
{
    public var dataField:String = "";
    public var condition:String = "";
    public var value:Object = "";
    public var backgroundColor:uint = 0xFFFFFF;
}