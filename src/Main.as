package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import menu.Menu;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	public class Main extends Engine 
	{
		
		public function Main():void 
		{
			super(800, 600, 60, true);
			
			FP.world = new Menu();
			FP.console.enable();
		}
		
	}
	
}