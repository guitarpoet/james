package net.guitarpoet.james.utils {
	import mx.collections.ListCollectionView;
	
	public class ListUtils {
		public static function remove(list : ListCollectionView, item : *) : * {
			for(var i : int = 0; i < list.length; i++){
				if(item == list.getItemAt(i)){
					return list.removeItemAt(i);
				}
			}
			return null;
		}
	}
}