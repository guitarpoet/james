package net.guitarpoet.james.events {
	import com.adobe.cairngorm.control.CairngormEvent;

	/**
	 * This is the universal message event. Every message fired in the system use ths event.
	 * So make it easy to handle all the messages propmt in the system.
	 *  
	 * @author jack
	 * 
	 */
	public class UniversalMessageEvent extends CairngormEvent {
		public var level : int;
		
		public var message : String;
		
		public static const TRACE : int = 0;
		
		public static const DEBUG : int = 1;
		
		public static const INFO : int = 2;
		
		public static const WARN : int = 3;
		
		public static const ERROR : int = 5;
		
		public static const FALTAL : int = 5; 
		
		public static const APPLICATION_MESSAGE_EVENT_TYPE : String = "james.application.message.event";
		
		public function UniversalMessageEvent(message : String, level : int = ERROR, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(APPLICATION_MESSAGE_EVENT_TYPE, bubbles, cancelable);
			this.message = message;
			this.level = level;
		}
		
	}
}