package resolumeCom.parameters
{
	import resolumeCom.events.ChangeEventBroadcaster;

	public class Parameter {

		public var name:String;
		public var type:Number;
		private var changeEventBroadcaster:ChangeEventBroadcaster;
		
		public function Parameter() {
			changeEventBroadcaster = new ChangeEventBroadcaster();
		}
		
		public function parameterChanged() {
			changeEventBroadcaster.sendValueChangedEvent(this);
		}
		
		public function addParameterListener(handler:Function)
		{
			changeEventBroadcaster.addEventListener(ChangeEventBroadcaster.VALUE_CHANGED, handler);			
		}
		
		public function getName() : String {
			return this.name;
		}
		
		public function getType() : Number {
			return this.type;
		}
	
		public function getXmlRep(): String
		{
			return "";		
		}
		
	}
	
}