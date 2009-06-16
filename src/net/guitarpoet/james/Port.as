package net.guitarpoet.james {
	import net.guitarpoet.james.events.UniversalMessageEvent;
		
	
	/**
	 * The port for state change.
	 *  
	 * @author jack
	 * 
	 */
	 [Bindable]
	public class Port {
		
		/**
		 * The name of the port. 
		 */
		public var name : String
		
		/**
		 * The state this port belongs to. 
		 */
		public var state : State;
		
		/**
		 * Port event string, if null then no event fired. 
		 */
		public var event : String;
		
		public var isDefault : Boolean;
		
		public var nextPortName : String;
		
		public var nextStateName : String;
		
		public function get next() : Port {
			if(!nextStateName || nextStateName == "" 
				|| !nextPortName || nextPortName == "")
				return null;
			// If the state is a flow, then port into its inner state.
			var flow : Viewflow = state is Viewflow ? state as Viewflow : state.flow;
			if(!nextStateName || nextStateName == ""){
				// If no state name, port to parent's exit port
				return state.flow.getExitPort(nextPortName);
			}
			if(!flow.getState(nextStateName)){
				trace("Can't find the next state.");
				return null;
			}
			return flow.getState(nextStateName).getInitPort(nextPortName);
		}
		
		public function Port(name : String = null) {
			this.name = name;
		}
				
		public function port() : void {
			if(event && event != "")
				new ViewflowEvent(event, state).dispatch();
		}
		
		public function populate(node : Object, parent : State) : Port {
			this.name = node.@name;
			this.event = node.@event;
			this.isDefault = node.@default == "true";
			this.nextStateName
			this.state = parent;
			this.nextStateName = node.@state;
			this.nextPortName = node.@next;
			return this;
		}
	}
}