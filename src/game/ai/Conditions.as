/*

	Рабочий класс кондишенов
	
	RaymondGames.com (c) 2010
*/

package game.ai
{
	public class Conditions
	{
		public var $length:uint=0;
		
		private var $conditions:Array = new Array(16);
		
		private var i:uint=0;
		private var j:uint=0;
		
		public function Clear():void
		{
			$length=0;
		}
		
		public function Set(condition:String):void
		{
			if($length>15)return;
			
			$conditions[$length]=condition;
			$length++;
		}
		
		public function Get(index:uint):String
		{
			return $conditions[index];
		}
		
		public function Has(index:String):Boolean
		{
			for(i=0; i<$length; i++)
			{
				if($conditions[i]==index)return true;
			}
			
			return false;
		}
		
		public function Trace():void
		{
			trace("\n\tCONDITIONS:\n");
			
			for(i=0; i<$length; i++)
			{
				trace("\t\t"+$conditions[i]);
			}
			trace("\t-----------\n");
		}
	}
}