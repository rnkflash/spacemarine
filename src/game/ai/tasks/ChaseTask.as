package game.ai.tasks 
{
	import game.ai.interfaces.AIControlInterface;
	import game.ai.Task;
	import net.flashpunk.FP;
	
	public class ChaseTask extends Task
	{
		private var chaser:AIControlInterface;
		private var chased:Object;
		private var range:Number;
		
		public function ChaseTask(chaser:AIControlInterface, chased:Object, range:Number)
		{
			super();
			this.chaser = chaser;
			this.chased = chased;
			this.range = range;
		}
		
		override public function Init():void
		{
			
		}
		
		override public function Stop():void
		{
			
		}				
		
		override public function Run():Boolean
		{
			var x:Number = chaser.AI_GetX();
			var y:Number = chaser.AI_GetY();
			var angle:Number = FP.angle(x, y, chased.x, chased.y);
			var speed:Number = chaser.AI_GetSpeed();
			
			chaser.AI_SetAngle(angle);
			
			if (FP.distance(x, y, chased.x, chased.y) <= range)
			{
				return true;
			}
			
			chaser.AI_MoveBy(speed * Math.cos(angle * FP.RAD), speed * Math.sin(angle * FP.RAD));
			
			
			return false;
		}		
		
		
	}

}