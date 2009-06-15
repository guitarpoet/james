package net.guitarpoet.james {
	import com.adobe.cairngorm.control.CairngormEvent;

	public class ViewflowEvent extends CairngormEvent {
		public function ViewflowEvent(type:String, data:*=null, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable);
			this.data = data;
		}
		
	}
}