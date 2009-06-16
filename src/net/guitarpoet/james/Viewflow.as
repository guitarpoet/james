package net.guitarpoet.james {
	/**
	 * The view flow for application navigation.
	 * 
	 * @author jack
	 * 
	 */
	public class Viewflow extends State {
		protected var stateMap : Object = {};
		
		public var currentState : State;
		
		public function Viewflow(name : String = null) {
			super(name);
		}
		
		public function start() : void {
			into();
		}
		
		public function addState(state : State) : void {
			stateMap[state.name] = state;
		}
		
		public function getState(name : String) : State {
			return stateMap[name] as State;
		}
		
		public function exitCurrentState(port : String = "default") : void {
			if(currentState)
				currentState.exit(port);
		}
				
		public function get states() : Array {
			var ss : Array = [];
			for (var p : String in stateMap) {
				if(stateMap[p] is State){
					ss.push(stateMap[p]);
				}
			}
			return ss;
		}
		
		public override function populate(node:*, flow:Viewflow):State {
			super.populate(node, flow);
			for each(var s : * in node.states.state) {
				var state : State = new State();
				state.populate(s, this);
				addState(state);
			}
			
			for each(var f : * in node.states.flow) {
				var flow : Viewflow = new Viewflow();
				flow.populate(f, this);
				addState(flow);
			}
			return this;
		}
	}
}