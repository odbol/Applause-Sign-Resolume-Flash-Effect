package resolumeCom.events
{
	import flash.events.Event;

	public class ChangeEvent extends Event
	{
		private var p_source:Object;

		public function ChangeEvent(e:String, p_source_:Object)
		{
			super(e, true, true);
			p_source = p_source_;
		}

		public function get object():Object
		{
			return p_source;
		}
		
		public override function toString():String
		{
			return "ChangeEvent";
		}
	}
}