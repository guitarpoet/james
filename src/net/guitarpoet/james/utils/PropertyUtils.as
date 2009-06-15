package net.guitarpoet.james.utils {
	public class PropertyUtils {
		public static function getProperty(obj : *, name : String) : Object {
			var steps : Array = name.split('.');
			
			var holder : Object = obj; 
			for each(var p : String in steps){
				holder = holder[p];
				if(!holder) return null;
			}
			return holder;
		}
	}
}