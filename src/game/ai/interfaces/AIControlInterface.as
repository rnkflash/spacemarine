package game.ai.interfaces 
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author rnk
	 */
	public interface AIControlInterface 
	{
		function AI_GetX():Number;
		function AI_GetY():Number;
		function AI_GetSpeed():Number;
		function AI_GetAngle():Number;
		
		function AI_Shoot(target:Object = null):Boolean;
		function AI_MoveBy(dx:Number, dy:Number):void;
		function AI_SetAngle(angle:Number):void;
	}
	
}