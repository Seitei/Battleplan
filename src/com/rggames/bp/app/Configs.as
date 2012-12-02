package com.rggames.bp.app
{
	import com.rggames.bp.world.entities.buildings.Building;
	import com.rggames.bp.world.entities.units.Unit;
	import com.rggames.bp.world.entities.units.UnitManager;
	
	import mx.collections.ArrayCollection;

	public class Configs
	{
		private static var _thronePos:Number;
		private static var _mapWidth:Number;
		private static var _mapHeight:Number;
		[Bindable]
		public static var mixedTurns:Boolean=true;
		[Bindable]
		public static var throneDestination:Boolean=true;
		[Bindable]
		public static var runDuration:int=10;
		[Bindable]
		public static var increaseRunDuration:Number=10;
		[Bindable]
		public static var maxUnits:int= 100;
		[Bindable]
		public static var unitSpeed:int= 2;
		[Bindable]
		public static var maxUnitsPerSpawn:int;
		[Bindable]
		public static var resourcePerTurn:int;
		[Bindable]
		public static var resourcePerBuilding:int;
		[Bindable]
		public static var spawnDelay:Number = 2000;
		[Bindable]
		public static var maxLevel:int = 10;
		[Bindable]
		public static var levelCostPercent:int = 200;
		[Bindable]
		public static var logs:String = "Output\r";
		
		public static function get mapHeight():Number
		{
			return _mapHeight;
		}
		
		[Bindable]		
		public static function set mapHeight(value:Number):void
		{
			var prevVal:Number=_mapHeight;
			
			_mapHeight = value;
			
			MainStarling.instance.map.height=value;
			
			MainStarling.instance.playerA.throne.x=MainStarling.instance.map.width*thronePos/100;
			MainStarling.instance.playerA.throne.y=MainStarling.instance.map.height*(1-thronePos/100);
			
			MainStarling.instance.playerB.throne.x=MainStarling.instance.map.width*(1-thronePos/100);
			MainStarling.instance.playerB.throne.y=MainStarling.instance.map.height*thronePos/100;
			
			for each (var building:Building in MainStarling.instance.buildings) 
			{
				building.y=(building.y/prevVal)*value;
			}
			for each (var unit:Unit in UnitManager.getUnits(0)) 
			{
				unit.y=(unit.y/prevVal)*value;
			}
			for each (unit in UnitManager.getUnits(1)) 
			{
				unit.y=(unit.y/prevVal)*value;
			}
		}
		
		public static function get mapWidth():Number
		{
			return _mapWidth;
		}
		
		[Bindable]
		public static function set mapWidth(value:Number):void
		{
			var prevVal:Number=_mapWidth;
			
			_mapWidth = value;
			MainStarling.instance.map.width=value;
			
			MainStarling.instance.playerA.throne.x=MainStarling.instance.map.width*thronePos/100;
			MainStarling.instance.playerA.throne.y=MainStarling.instance.map.height*(1-thronePos/100);
			
			MainStarling.instance.playerB.throne.x=MainStarling.instance.map.width*(1-thronePos/100);
			MainStarling.instance.playerB.throne.y=MainStarling.instance.map.height*thronePos/100;
			
			for each (var building:Building in MainStarling.instance.buildings) 
			{
				building.x=(building.x/prevVal)*value;
			}
			for each (var unit:Unit in UnitManager.getUnits(0)) 
			{
				unit.x=(unit.x/prevVal)*value;
			}
			for each (unit in UnitManager.getUnits(1)) 
			{
				unit.x=(unit.x/prevVal)*value;
			}
		}
		
		public static function get thronePos():Number
		{
			return _thronePos;
		}
		
		[Bindable]
		public static function set thronePos(value:Number):void
		{
			_thronePos = value;
			MainStarling.instance.playerA.throne.x=MainStarling.instance.map.width*value/100;
			MainStarling.instance.playerA.throne.y=MainStarling.instance.map.height*(1-value/100);
			
			MainStarling.instance.playerB.throne.x=MainStarling.instance.map.width*(1-value/100);
			MainStarling.instance.playerB.throne.y=MainStarling.instance.map.height*value/100;
		}
		
		//////////////
		[Bindable]
		public static var res1Dmg1:int = 10;
		[Bindable]
		public static var res1Dmg2:int = 20;
		[Bindable]
		public static var res1Dmg3:int = 40;
		[Bindable]
		public static var res1Dmg4:int = 90;
		[Bindable]
		public static var res1Dmg5:int = 250;
		[Bindable]
		
		public static var res1Cost1:int = 5;
		[Bindable]
		public static var res1Cost2:int = 10;
		[Bindable]
		public static var res1Cost3:int = 20;
		[Bindable]
		public static var res1Cost4:int = 40;
		[Bindable]
		public static var res1Cost5:int = 100;
		
		//////////////
		[Bindable]
		public static var unit1Dmg1:int = 10;
		[Bindable]
		public static var unit1Dmg2:int = 20;
		[Bindable]
		public static var unit1Dmg3:int = 40;
		[Bindable]
		public static var unit1Dmg4:int = 90;
		[Bindable]
		public static var unit1Dmg5:int = 250;
		[Bindable]
		
		public static var unit1Cost1:int = 5;
		[Bindable]
		public static var unit1Cost2:int = 10;
		[Bindable]
		public static var unit1Cost3:int = 20;
		[Bindable]
		public static var unit1Cost4:int = 40;
		[Bindable]
		public static var unit1Cost5:int = 100;
		
		
		////////////
		[Bindable]
		public static var unit2Dmg1:int = 30;
		[Bindable]
		public static var unit2Dmg2:int = 60;
		[Bindable]
		public static var unit2Dmg3:int = 120;
		[Bindable]
		public static var unit2Dmg4:int = 270;
		[Bindable]
		public static var unit2Dmg5:int = 750;
		
		[Bindable]
		public static var unit2Cost1:int = 15;
		[Bindable]
		public static var unit2Cost2:int = 30;
		[Bindable]
		public static var unit2Cost3:int = 60;
		[Bindable]
		public static var unit2Cost4:int = 120;
		[Bindable]
		public static var unit2Cost5:int = 260;
		
		
		//////////////
		[Bindable]
		public static var unit3Dmg1:int = 4;
		[Bindable]
		public static var unit3Dmg2:int = 8;
		[Bindable]
		public static var unit3Dmg3:int = 16;
		[Bindable]
		public static var unit3Dmg4:int = 40;
		[Bindable]
		public static var unit3Dmg5:int = 110;
		
		[Bindable]
		public static var unit3Cost1:int = 5;
		[Bindable]
		public static var unit3Cost2:int = 10;
		[Bindable]
		public static var unit3Cost3:int = 20;
		[Bindable]
		public static var unit3Cost4:int = 40;
		[Bindable]
		public static var unit3Cost5:int = 100;
		
		[Bindable]
		public static var unit3AOE1:int = 40;
		[Bindable]
		public static var unit3AOE2:int = 45;
		[Bindable]
		public static var unit3AOE3:int = 50;
		[Bindable]
		public static var unit3AOE4:int = 55;
		[Bindable]
		public static var unit3AOE5:int = 60;
	}
}