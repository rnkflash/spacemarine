package game.ai.brains 
{
	import flash.geom.Rectangle;
	import game.ai.*;
	import game.ai.tasks.AttackTask;
	import game.ai.tasks.ChaseTask;
	import game.ai.tasks.WanderTask;
	import game.objects.Alien;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author rnk
	 */
	public class WanderingAlienAI extends AI
	{
		
		//conditions
		public static const CONDITION_I_SEE_HERO:String = "CONDITION_I_SEE_HERO";
		public static const CONDITION_HERO_OUT_OF_RANGE:String = "CONDITION_HERO_OUT_OF_RANGE";
		
		//states
		public static const STATE_SEARCHING_HERO:uint = 1;
		
		//shedules
		public static const SHEDULE_WANDER_UNTIL_SEE_HERO:uint = 0;
		public static const SHEDULE_CHASE_AND_ATTACK_HERO:uint = 1;
		
		//
		public var alien:Alien;
		public var hero:Entity;
		public var see_distance:Number = 400;
		
		public function WanderingAlienAI(alien:Alien, hero:Entity, area:Rectangle)
		{
			super();
			
			this.alien = alien;
			this.hero = hero;
			
			$Shedules = [
				new Shedule(
					"wander around until i see player", 
					[CONDITION_I_SEE_HERO], 
					[new WanderTask(alien, area)]
				),
				new Shedule(
					"chase and attack player", 
					[CONDITION_HERO_OUT_OF_RANGE], 
					[new ChaseTask(alien, hero, 200), new AttackTask(alien, hero)]
				)
				
			];
				
			$Shedule = SHEDULE_WANDER_UNTIL_SEE_HERO;
			$State = STATE_SEARCHING_HERO;
			
		}
		
		override public function GenerateConditions():void
		{
			var dist:Number = FP.distance(alien.x, alien.y, hero.x, hero.y);
			
			if (dist <= see_distance)
			{
				$Conditions.Set(CONDITION_I_SEE_HERO);
			} else
			{
				$Conditions.Set(CONDITION_HERO_OUT_OF_RANGE);				
			}
			
		}		
		
		
		override public function SelectNewShedule():void
		{
			switch($State)
			{
				case STATE_SEARCHING_HERO:
							
					if($Conditions.Has(CONDITION_I_SEE_HERO))
					{
						$Shedule=SHEDULE_CHASE_AND_ATTACK_HERO;
						
						break;
					}
					else
					{
						$Shedule=SHEDULE_WANDER_UNTIL_SEE_HERO;
					}
					
				break;
			}	
		}
		
	}

}