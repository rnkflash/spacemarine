package game.ai.tasks 
{
	import game.ai.interfaces.AIControlInterface;
	import game.ai.Task;
	import game.objects.Bullet;
	import net.flashpunk.FP;
	
	public class AttackTask extends Task
	{
		
		private var attacker:AIControlInterface;
		private var target:Object;
		private var last_known_location:Object = { x:0, y:0 };

		
		public function AttackTask(attacker:AIControlInterface, target:Object) 
		{
			super();
			this.attacker = attacker;
			this.target = target;
			last_known_location.x = target.x;
			last_known_location.y = target.y;
		}
		
		
		override public function Init():void
		{
			
		}
		
		override public function Stop():void
		{
			
		}				
		
		override public function Run():Boolean
		{
			var x:Number = attacker.AI_GetX();
			var y:Number = attacker.AI_GetY();
			
			var v:Object = { x:target.x - last_known_location.x, y:target.y - last_known_location.y };
			
			var fire_solution:Object = FireSolution( { x:x, y:y }, { x:target.x, y:target.y, vx:v.x, vy:v.y }, Bullet.speed );
			if (fire_solution)
			{
				//fire with precision
				var angle:Number = FP.angle(x, y, fire_solution.x, fire_solution.y);
				attacker.AI_SetAngle(angle);
				attacker.AI_Shoot(target);
			}
			else
			{
				//fire anyway
				angle = FP.angle(x, y, target.x, target.y);
				attacker.AI_SetAngle(angle);
				attacker.AI_Shoot(target);
			}
			
			last_known_location.x = target.x;
			last_known_location.y = target.y;
			
			return false;
		}
		
		/**
		 * Return the firing solution for a projectile starting at 'src' with
		 * velocity 'v', to hit a target, 'dst'.
		 *
		 * @param Object src position of shooter
		 * @param Object dst position & velocity of target
		 * @param Number v   speed of projectile
		 * @return Object Coordinate at which to fire (and where intercept occurs)
		 *
		 * E.g.
		 * >>> intercept({x:2, y:4}, {x:5, y:7, vx: 2, vy:1}, 5)
		 * = {x: 8, y: 8.5}
		 */
		private function FireSolution(src:Object, dst:Object, v:Number):Object
		{
		  var tx:Number = dst.x - src.x,
			  ty:Number = dst.y - src.y,
			  tvx:Number = dst.vx,
			  tvy:Number = dst.vy;
		  // Get quadratic equation components
		  var a:Number = tvx*tvx + tvy*tvy - v*v;
		  var b:Number = 2 * (tvx * tx + tvy * ty);
		  var c:Number = tx*tx + ty*ty;    
		  // Solve quadratic
		  var ts:Array = quad(a, b, c); // See quad(), below
		  // Find smallest positive solution
		  var sol:Object = null;
		  if (ts) {
			var t0:Number = ts[0], t1:Number = ts[1];
			var t:Number = Math.min(t0, t1);
			if (t < 0) t = Math.max(t0, t1);    
			if (t > 0) {
			  sol = {
				x: dst.x + dst.vx*t,
				y: dst.y + dst.vy*t
			  };
			}
		  }
		  return sol;
		}
		/**
		 * Return solutions for quadratic
		 */
		private function quad(a:Number,b:Number,c:Number):Array {
		  var sol:Array = null;
		  if (Math.abs(a) < 1e-6) {
			if (Math.abs(b) < 1e-6) {
			  sol = Math.abs(c) < 1e-6 ? [0,0] : null;
			} else {
			  sol = [-c/b, -c/b];
			}
		  } else {
			var disc:Number = b*b - 4*a*c;
			if (disc >= 0) {
			  disc = Math.sqrt(disc);
			  a = 2*a;
			  sol = [(-b-disc)/a, (-b+disc)/a];
			}
		  }
		  return sol;
		}
	}

}