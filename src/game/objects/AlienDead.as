package game.objects 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	public class AlienDead extends Entity
	{
		private var spr:Image;
		public var angle:Number = 0;
		
		
		public function AlienDead() 
		{
			layer = -1;
			spr = new Image(Assets.ALIEN_DEAD);
			spr.originX = 44;
			spr.originY = 65;
			spr.smooth = true;
			
			addGraphic(spr);
			
		}
		
		override public function update():void 
		{
			spr.angle = angle - 90;
		}
		
	}

}