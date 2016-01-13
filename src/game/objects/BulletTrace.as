package game.objects 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	public class BulletTrace extends Entity
	{
		private var spr:Image;
		public var angle:Number = 0;
		
		public function BulletTrace() 
		{
			layer = -3;
			spr = new Image(Assets.PLASMA);
			spr.originX = spr.width/2;
			spr.originY = spr.height/2;
			spr.smooth = true;
			addGraphic(spr);
			
		}
		
		public function ReInit():void
		{
			spr.scale = 1.0;
		}
		
		override public function update():void 
		{
			spr.angle += 15;
			spr.scale -= 0.1;
			
			//death
			if ( spr.scale <= 0 )
			{
				Kill();
			}
		}
		
		public function Kill():void
		{
			world.remove(this);
			
		}
		
		override public function removed():void 
		{
			ObjectPool.Push(this);
		}
		
		
		public static function Get():BulletTrace
		{
			var b:BulletTrace = ObjectPool.Get(BulletTrace);
			if (!b)
				b = new BulletTrace();
			else
				b.ReInit();
			return b;
		}
		
	}

}