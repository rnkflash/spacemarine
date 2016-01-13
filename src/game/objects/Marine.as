package game.objects 
{
	import game.Game;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	public class Marine extends Entity
	{
		private var spr:Image;
		private var rof_timer:Number = 0;
		public var angle:Number = 0;
		
		public function Marine() 
		{
			layer = -2;
			spr = new Image(Assets.MARINE);
			spr.originX = 25;
			spr.originY = 78;
			spr.smooth = true;
			
			addGraphic(spr);
			
			setHitbox(40, 40, 20, 20);
			type = "marine";
			
		}
		
		override public function update():void 
		{
			//rotation
			angle = FP.angle(x, y, world.mouseX, world.mouseY);
			spr.angle = angle - 90;
			
			//movement
			var dx:Number = 0;
			var dy:Number = 0;
			var speed:Number = 5;
			if (Input.check(Key.W))
			{
				dy = -speed;
			} else
			if (Input.check(Key.S))
			{
				dy = speed;
			}
			if (Input.check(Key.A))
			{
				dx = -speed;
			} else
			if (Input.check(Key.D))
			{
				dx = speed;
			}
			moveBy(dx, dy);
			
			//walls
			x = FP.clamp(x, 0, (world as Game).width);
			y = FP.clamp(y, 0, (world as Game).height);
			
			
			//shootation
			if (rof_timer > 0)
			{
				rof_timer++;
				if (rof_timer > 5)
					rof_timer = 0;
			}
			if (Input.mouseDown)
			{
				Shoot()
			}
			
			//collision
			var b:Bullet = collide("bullet", x, y) as Bullet;
			if (b)
			{
				b.Kill();
			}
			
		}
		
		private function Shoot():void
		{
			if (rof_timer++ > 0)
				return;
			var bullet:Bullet = Bullet.GetBullet();
			bullet.x = x + 78 * Math.cos(angle * FP.RAD);
			bullet.y = y + 78 * Math.sin(angle * FP.RAD);
			bullet.angle = angle + (Math.random() * 5 - 2.5);
			world.add(bullet);
		}
		
	}

}