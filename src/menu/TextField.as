package menu 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	/**
	 * ...
	 * @author lolcho
	 */
	public class TextField extends Entity
	{
		public var text:Text;
		
		public function TextField(txt:String = "", color:uint = 0x0080FF) 
		{
			text = new Text(txt, 0, 0, { color:color }, 0);
			graphic = text;
		}
		
	}

}