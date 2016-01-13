/*

	Рабочий класс шедулей
	
	RaymondGames.com (c) 2010
*/

package game.ai
{
	public class Shedule
	{
		public var $name:String="noname";
		
		private var $interrupts:Array = new Array();
		private var $tasks:Array = new Array();
		
		private var $cur_task:uint=0;
		private var $bCompleted:Boolean=false;
		
		private var i:uint=0;
		private var j:uint=0;
		
		
		private var taskFirstRun:Boolean = true;
		
		public function Shedule(name_:String, interrupts:Array, tasks:Array)
		{
			$name=name_;
			
			for(i=0; i<interrupts.length; i++)
			{
				$interrupts.push(interrupts[i]);
			}
			
			for(i=0; i<tasks.length; i++)
			{
				$tasks.push(tasks[i]);
			}
			
			$cur_task=0;
			$bCompleted=false;
			
		}
		
		public function AddInterrupt(interrupt:uint):void
		{
			$interrupts.push(interrupt);
		}
		
		public function Run():void
		{
			//trace("running... "+$name);
			
			if($bCompleted)return;
			
			if (taskFirstRun) 
			{
				$tasks[$cur_task].Init();
				taskFirstRun = false;
			}
			if($tasks[$cur_task].Run())
			{
				$tasks[$cur_task].Stop();
				$cur_task++;
				taskFirstRun = true;
			}
			
			if($cur_task==$tasks.length)
			{
				$cur_task=0;
				$bCompleted=true;
			}
		}
		
		public function Stop():void
		{
			if ($tasks[$cur_task])
				{
					$tasks[$cur_task].Stop();
					taskFirstRun = true;
				}
			$cur_task=0;
			$bCompleted=true;
		}
		
		public function isDone(conditions:Conditions):Boolean
		{
			if($bCompleted)
			{ 
				Reset();
				
				return true; 
			}
			
			for(i=0; i<conditions.$length; i++)
			{
				for(j=0; j<$interrupts.length; j++)
				{
					//trace("Shedule " + $name +" Condition check: "+conditions.Get(i) + " vs " + $interrupts[j]);
					
					if(conditions.Get(i)==$interrupts[j])
					{
						Reset();
						
						return true;
					}
				}
			}
			
			return false;	
		}
		
		private function Reset():void
		{
			taskFirstRun = true;
			$cur_task=0;
			$bCompleted=false;
		}
	}
}