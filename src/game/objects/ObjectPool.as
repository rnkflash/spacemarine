package game.objects 
{
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author rnk
	 */
	public class ObjectPool 
	{
		
		public static var pool:Dictionary = new Dictionary();
		
		public static function Push(obj:*):void
		{
			var cls:Class = Class(getDefinitionByName(getQualifiedClassName(obj)));
			if (!pool[cls])
				pool[cls] = [];
			pool[cls].push(obj);
		} 
		
		public static function Get(cls:Class):*
		{
			if (!pool[cls])
				return null;
			return pool[cls].shift();
		}
		
		public static function Clear():void
		{
			for each (var subpool:* in pool) 
			{
				subpool.splice(0);
			}
		}
		
	}

}