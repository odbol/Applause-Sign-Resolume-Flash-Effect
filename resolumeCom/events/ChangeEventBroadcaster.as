package resolumeCom.events
{
	
	import flash.events.EventDispatcher;
	import resolumeCom.events.ChangeEvent;
	
	public class ChangeEventBroadcaster extends EventDispatcher {
		public static var VALUE_CHANGED:String = "valueChanged";
	
		public function sendValueChangedEvent(sender:Object):void {
			dispatchEvent( new ChangeEvent(ChangeEventBroadcaster.VALUE_CHANGED, sender) );
		}
	}

}