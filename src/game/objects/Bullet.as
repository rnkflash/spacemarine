package game.objects 
{
	import flash.display.BlendMode;
	import game.Game;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	public class Bullet extends Entity
	{
		private var spr:Image;
		public static var speed:Number = 13;
		public var angle:Number = 0;
		public var dmg:Number = 20.0;
		
		public function Bullet() 
		{
			layer = -3;
			spr = new Image(Assets.PLASMA);
			spr.originX = spr.width/2;
			spr.originY = spr.height/2;
			spr.smooth = true;
			spr.blend = BlendMode.ADD;
			addGraphic(spr);
			var bsize:uint = 16;
			setHitbox(bsize, bsize, bsize / 2, bsize / 2);
			type = "bullet";
		}
		
		override public function update():void 
		{
			moveBy(speed * Math.cos(angle * FP.RAD), speed * Math.sin(angle * FP.RAD));
			
			spr.angle += 15;
			
			//death
			if ( x > (FP.world as Game).width || y > (FP.world as Game).height || x < 0 || y < 0 )
			{
				Kill();
			}
		}
		
		public function Kill():void
		{
			var b:BulletTrace = BulletTrace.Get();
			b.x = x;
			b.y = y;
			world.add(b);
			
			world.remove(this);
			
		}
		
		override public function removed():void 
		{
			ObjectPool.Push(this);
		}
		
		public static function GetBullet():Bullet
		{
			var b:Bullet = ObjectPool.Get(Bullet);
			if (!b)
				b = new Bullet();
			return b;
		}
		
	}

}