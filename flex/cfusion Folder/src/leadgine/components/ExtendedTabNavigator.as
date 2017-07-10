package leadgine.components
{
    import flash.events.MouseEvent;
    import leadgine.events.TabEvent;
    import mx.containers.TabNavigator;
    import mx.controls.Button;
    import mx.events.FlexEvent;
    import mx.events.ItemClickEvent;

    public class ExtendedTabNavigator extends TabNavigator
    {
        public function ExtendedTabNavigator()
        {
            super();
            
            // add creation complete handler
            addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
        }
        
        /**
         * Adds an event listener to monitor the ItemClickEvent.ITEM_CLICK on the tabBar
         * plus a listener to monitor the FlexEvent.UPDATE_COMPLETE event
         */
        private function creationCompleteHandler(ev:FlexEvent):void
        {
            tabBar.addEventListener(ItemClickEvent.ITEM_CLICK, itemClickEventHandler);
            tabBar.addEventListener(FlexEvent.UPDATE_COMPLETE, updateCompleteHandler);
        }
        
        /**
         * Adds event listeners for a selection of MouseEvents to each button in the tabBar 
         */
        private function updateCompleteHandler(ev:FlexEvent):void
        {            
            for each (var button:Button in tabBar.getChildren())
            {            
                button.addEventListener(MouseEvent.MOUSE_OVER, mouseEventHandler);
                button.addEventListener(MouseEvent.MOUSE_OUT, mouseEventHandler);
                button.addEventListener(MouseEvent.MOUSE_DOWN, mouseEventHandler);
                button.addEventListener(MouseEvent.MOUSE_UP, mouseEventHandler);
            }
        }
        
        /**
         * Dispatches a TabEvent.TAB_ITEMCLICK_ACTIVITY event containing the received MouseEvent
         */
        private function itemClickEventHandler(ev:ItemClickEvent):void
        {
            var tabEvent:TabEvent = new TabEvent(TabEvent.TAB_ITEMCLICK_ACTIVITY, ev);
            dispatchEvent(tabEvent);
        }
        
        /**
         * Dispatches a TabEvent.TAB_MOUSE_ACTIVITY event containing the received MouseEvent
         */
        private function mouseEventHandler(ev:MouseEvent):void
        {
            var tabEvent:TabEvent = new TabEvent(TabEvent.TAB_MOUSE_ACTIVITY, ev);
            dispatchEvent(tabEvent);
        }

    }
}