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
	}
}