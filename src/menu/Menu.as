package menu 
{
	import game.Game;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	
	public class Menu extends World
	{
		
		public function Menu() 
		{
			var txt:Text = new Text("HOTLINE MIAMI IN SCI FI SETTING", 0, 0, { color:0x009FFF, size:32 } );
			addGraphic(txt, 0, FP.width / 2 - txt.width / 2, FP.height / 2 - 100);
			
			txt = new Text("press any key or click to start", 0, 0, { color:0x009FFF } );
			addGraphic(txt, 0, FP.width / 2 - txt.width / 2, FP.height / 2);
			
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.pressed(Key.ANY) || Input.mouseReleased)
			{
				FP.world = new Game();
			}
		}
		
	}

}