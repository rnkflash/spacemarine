package game.objects 
{
	import game.ai.AI;
	import game.ai.interfaces.AIControlInterface;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	public class Alien extends Entity implements AIControlInterface
	{
		private var spr:Image;
		public var angle:Number = 0;
		public var speed:Number = 2.5;
		public var dx:Number = 0;
		public var dy:Number = 0;
		public var hp:Number = 100.0;
		public var rof_timer:Number = 0;
		
		public var brain:AI;
		
		public function Alien() 
		{
			layer = -2;
			
			spr = new Image(Assets.ALIEN);
			spr.originX = 28;
			spr.originY = 63;
			spr.smooth = true;
			
			addGraphic(spr);
			
			setHitbox(50, 50, 25, 25);
			type = "alien";
			
		}
		
		override public function update():void 
		{
			if (brain)
				brain.Update();
			
			//angle
			spr.angle = angle - 90;
			
			//move
			moveBy(dx, dy);
			dx = 0;
			dy = 0;
			
			//shootation
			if (rof_timer > 0)
			{
				rof_timer++;
				if (rof_timer > 20)
					rof_timer = 0;
			}
			
			//collision
			var b:Bullet = collide("bullet", x, y) as Bullet;
			if (b)
			{
				hp -= b.dmg;
				b.Kill();
			}
			if (hp <= 0)
			{
				Kill();
			}
		}
		
		public function Kill():void
		{
			collidable = false;
			world.remove(this);
			if (brain)
			{
				brain.Die();
				brain = null;
			}
			
			//dead body
			var body:AlienDead = new AlienDead();
			body.x = x;
			body.y = y;
			body.angle = angle;
			world.add(body);			
		}
		
		private function Shoot():Boolean
		{
			if (rof_timer++ > 0)
				return false;
			var bullet:Bullet = Bullet.GetBullet();
			bullet.x = x + 50 * Math.cos(angle * FP.RAD);
			bullet.y = y + 50 * Math.sin(angle * FP.RAD);
			bullet.angle = angle + (Math.random() * 5 - 2.5);
			world.add(bullet);
			return true;
		}
		
		
		/* INTERFACE game.ai.interfaces.AIControlInterface */
		
		public function AI_GetX():Number 
		{
			return x;
		}
		
		public function AI_GetY():Number 
		{
			return y;
		}
		
		public function AI_GetSpeed():Number 
		{
			return speed;
		}
		
		public function AI_GetAngle():Number 
		{
			return angle;
		}
		
		public function AI_Shoot(target:Object = null):Boolean 
		{
			return Shoot();
		}
		
		public function AI_MoveBy(dx:Number, dy:Number):void 
		{
			this.dx = dx;
			this.dy = dy;
		}
		
		public function AI_SetAngle(angle:Number):void 
		{
			this.angle = angle;
		}
		
	}

}