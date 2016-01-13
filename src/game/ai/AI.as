/*

	Это просто пример использования шедулей. Компилировать не пытайтесь :D
	Надеюсь что этот кусок кода даст Вам ключ к работе с shedule-based AI.

	RaymondGames.com (c) 2010
*/

package game.ai
{

	public class AI
	{		
		// AI vars	--------------------------
		public var $think_time:Number=0;
		public var $think_timeout:Number=30;
	
		public var $Conditions:Conditions=new Conditions();
		
		public var $State:uint=0;
		
		public var $Shedule:uint;
		public var $Shedules:Array=new Array();
		
		//------------------------------------
		
		/*--------------------------------------------------------
					ENUM STATES
		---------------------------------------------------------*/
		public static const STATE_CALM:uint=0;



		/*--------------------------------------------------------
					ENUM SHEDULES
		---------------------------------------------------------*/
		public static const SHED_IDLE:uint=0;	//можно сделать var и назначать прямо на ходу, но я решил делать так
	
		public function AI()
		{
			$Shedules = [new Shedule("do nothing", [], [new Task()])];
			$State=STATE_CALM;
			$Shedule=SHED_IDLE;
		}
		
		public function Die():void
		{
			
		}
		
		/*--------------------------------------------------------
							UPDATE SCRIPT
		---------------------------------------------------------*/
		public function Update():void
		{
			if($think_time>$think_timeout)
			{
				$think_time=0;
				Think();
			}
			$think_time++;
			$Shedules[$Shedule].Run();
		}
		
		/*---------------------------------------------------------------------
								THINK
		---------------------------------------------------------------------*/
		public function Think():void
		{			

			$Conditions.Clear();
			
			GenerateConditions();
			
			//---------------------------------------------------------------------------------------------
			//	3. Choose an appropriate State
			//---------------------------------------------------------------------------------------------

			//ChooseState(); //стейты можно выбирать и здесь (разбивка из оригинальной статьи на вики valve)
			
			//---------------------------------------------------------------------------------------------
			//	4. Select a new Schedule if appropriate
			//---------------------------------------------------------------------------------------------
			if($Shedules[$Shedule].isDone($Conditions))
			{		
				SelectNewShedule();
			}
			
			//---------------------------------------------------------------------------------------------
			//	5. Perform the current Task - put this to runtime
			//---------------------------------------------------------------------------------------------
			//$Shedule.Run(this); //у нас итак шедули выполняются в рантайме (см.выше)
		}
		
		/*---------------------------------------------------------------------
								GENERATE CONDITIONS
		---------------------------------------------------------------------*/
		public function GenerateConditions():void
		{
			
		}
		
		/*---------------------------------------------------------------------
								SELECT NEW SHEDULE
		---------------------------------------------------------------------*/
		public function SelectNewShedule():void
		{

		}
		

		

	}
}
