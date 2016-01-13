package game 
{
	import flash.geom.Rectangle;
	import game.ai.brains.WanderingAlienAI;
	import game.objects.Alien;
	import game.objects.Marine;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.TiledImage;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	
	public class Game extends World
	{
		private var player:Marine;
		
		/** Camera following information. */
		public const FOLLOW_TRAIL:Number = 50;
		public const FOLLOW_RATE:Number = .9;
		
		/** Size of the level (so it knows where to keep the player + camera in). */
		public var width:uint = 1600;
		public var height:uint = 1200;
		
		public function Game() 
		{
			
		}
		
		override public function end():void 
		{
			
		}
		
		override public function begin():void 
		{
			//tiles
			var tiledImg:TiledImage = new TiledImage(Assets.TILE1, width, height);
			addGraphic(tiledImg);
			
			
			//objects
			player = new Marine();
			add(player);
			player.x = FP.width / 2;
			player.y = FP.height / 2;
			
			for (var i:int = 0; i < 100; i++) 
			{
				var alien:Alien = new Alien();
				add(alien);
				alien.brain = new WanderingAlienAI(alien, player, new Rectangle(0, 0, width, height));
				alien.x = Math.random() * width;
				alien.y = Math.random() * height;
				alien.angle = Math.random() * 360;
				
			}
			
			
		}
		
		
		override public function update():void 
		{
			super.update();
			cameraFollow();
			
			if (Input.pressed(Key.R))
			{
				FP.world = new Game();
			}
		}
		
		/** Makes the camera follow the player object. */
		private function cameraFollow():void
		{
			// make camera follow the player
			FP.point.x = FP.camera.x - targetX;
			FP.point.y = FP.camera.y - targetY;
			var dist:Number = FP.point.length;
			if (dist > FOLLOW_TRAIL) dist = FOLLOW_TRAIL;
			FP.point.normalize(dist * FOLLOW_RATE);
			FP.camera.x = int(targetX + FP.point.x);
			FP.camera.y = int(targetY + FP.point.y);
			
			// keep camera in room bounds
			FP.camera.x = FP.clamp(FP.camera.x, 0, width - FP.width);
			FP.camera.y = FP.clamp(FP.camera.y, 0, height - FP.height);
		}
		
		/** The player's X location. */
		private function get targetX():Number { return player.x - FP.width / 2; }
		
		/** The player's Y location. */
		private function get targetY():Number { return player.y - FP.height / 2; }
		
	}

}