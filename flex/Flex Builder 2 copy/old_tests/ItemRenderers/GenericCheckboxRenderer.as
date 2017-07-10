// ActionScript file
package ItemRenderers
{
    import mx.controls.CheckBox;
    import flash.events.MouseEvent;
    import mx.controls.Alert;

    public class GenericCheckboxRenderer extends CheckBox
    {
        public function GenericCheckboxRenderer() {
            super();
        }
        
        override protected function clickHandler(event:MouseEvent):void {
            if (!enabled) {
                    // Prevent the propagation of click from a disabled Button.
                    // This is conceptually a higher-level event and
                    // developers will expect their click handlers not to fire
                    // if the Button is disabled.
                    event.stopImmediatePropagation();
                    return;
            }
        
            if (toggle) {
                selected = !selected;
            }
        }
    }
}