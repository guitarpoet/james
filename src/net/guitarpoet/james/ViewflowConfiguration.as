package net.guitarpoet.james {
	/**
	 * This read the xml configuration to make up the viewflow. 
	 *  
	 * @author jack
	 * 
	 */
	public class ViewflowConfiguration {
		public var flow : Viewflow;
		
		public function set config(xml : XML) : void {
			flow = new Viewflow();
			flow.populate(xml, null);	
		}
		
		public function get currentActiveState() : State {
			if(!flow)
				return null;
			var s : State = flow.currentState;
			while(s is Viewflow){
				s = Viewflow(s).currentState;
			}
			return s;
		}
	}
}