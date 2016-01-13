package game.ai.tasks 
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import game.ai.interfaces.AIControlInterface;
	import game.ai.Task;
	import net.flashpunk.FP;
	
	public class WanderTask extends Task
	{
		
		private var wanderer:AIControlInterface;
		private var area:Rectangle;
		
		private var destination:Point;
		private var time:Number = 0;
		
		public function WanderTask(wanderer:AIControlInterface, area:Rectangle)
		{
			super();
			this.wanderer = wanderer;
			this.area = area;
			
		}
		
		override public function Init():void
		{
			PickDestination();
		}
		
		override public function Stop():void
		{
			
		}			
		
		override public function Run():Boolean
		{
			if (!destination)
				PickDestination();
			
			if (destination)
			{
				var x:Number = wanderer.AI_GetX();
				var y:Number = wanderer.AI_GetY();
				var angle:Number = FP.angle(x, y, destination.x, destination.y);
				var speed:Number = wanderer.AI_GetSpeed();
				
				wanderer.AI_MoveBy(speed * Math.cos(angle * FP.RAD), speed * Math.sin(angle * FP.RAD));
				wanderer.AI_SetAngle(angle);
				
				if (FP.distance(x, y, destination.x, destination.y) < 10 || time++>=60)
					destination = null;
				
			}
			
			return false;
		}		
		
		private function PickDestination():void
		{
			
			destination = new Point(area.x + Math.random() * area.width, area.y + Math.random() * area.height);
			time = 0;
			
		}
		
	}

}