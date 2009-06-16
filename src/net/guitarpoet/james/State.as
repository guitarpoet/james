package net.guitarpoet.james {
	import mx.utils.ObjectUtil;
	
	import net.guitarpoet.james.events.UniversalMessageEvent;
	
	/**
	 * The pageflow state. Stands for the state of the view(mostly). Use a flow machenism to 
	 * manage view states.
	 * 
	 * @author jack
	 * 
	 */
	 [Bindable]
	public class State {
		
		public var name : String;
		
		public var view : String;
		
		public static const STATE_CHANGED : String = "flow_state_changed";
		
		/**
		 * The viewflow this state belongs to. 
		 */
		public var flow : Viewflow;
		
		protected var inits : Object = {};
		
		protected var exits : Object = {};
		
		public function State(name : String = null){
			this.name = name;
		}
		
		protected function portTo(port : Port) : void {
			port.port();
			if(port.next) {
				if(port.nextStateName != this.name) {
					port.next.state.into(port.nextPortName);
					new ViewflowEvent(STATE_CHANGED, [this, port.next.state]).dispatch();
				}
			}
		}
		
		public function addInitPort(port : Port) : void {
			inits[port.name] = port;
		}
		
		public function addExitPort(port : Port) : void {
			exits[port.name] = port;
		}
		
		public function into(port : String = "default") : void {
			if(flow)
				flow.currentState = this;
			if(inits[port]){
				portTo(inits[port] as Port);
				return;
			}
			if(defaultInitPort){
				portTo(defaultInitPort);
				return;
			}
			new UniversalMessageEvent("Can't find port {" + port + "} to go into this state.").dispatch();
		}
		
		public function exit(port : String = "default") : void {
			if(exits[port]){
				portTo(exits[port] as Port);
				return;
			}
			if(defaultExitPort){
				portTo(defaultExitPort);
				return;
			}
			new UniversalMessageEvent("Can't find port {" + port + "} to exit this state.").dispatch();
		}
		
		
		/**
		 * Get all the init ports 
		 * @return 
		 * 
		 */
		public function get initPorts() : Array {
			return getPorts(inits);
		}
		
		public function getInitPort(name : String) : Port {
			return inits[name] as Port; 
		}
		
		public function getExitPort(name : String) : Port {
			return exits[name] as Port;
		}
		
		protected function getPorts(obj : Object) : Array {
			var ps : Array = [];
			for(var p : String in obj){
				if(obj[p] is Port){
					ps.push(obj[p]);
				}
			}
			return ps;
		}
		
		public function get exitPorts() : Array {
			return getPorts(exits);
		}
		
		public function getDefaultPort(arr :Array) : Port {
			for each(var p : Port in arr){
				if(p.isDefault)
					return p;
			}
			return null;
		}
		
		public function get defaultExitPort() : Port {
			return getDefaultPort(exitPorts);
		}
		
		public function get defaultInitPort() : Port {
			return getDefaultPort(initPorts);
		}
		
		public function toString() : String {
			return ObjectUtil.toString(this);
		}
		
		public function populate(node : *, flow : Viewflow) : State {
			this.name = node.@name;
			this.view = node.@view;
			this.flow = flow;
			for each(var p : * in node.init.port){
				var port : Port = new Port();
				port.populate(p, this);
				addInitPort(port);
			}
			for each(var ep : * in node.exit.port){
				var eport : Port = new Port();
				eport.populate(ep, this);
				addExitPort(eport);
			}
			return this;
		}
	}
}