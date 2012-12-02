package com.rggames.bp.world.entities.units
{
	public class UnitManager
	{
		private static var unitsA:Vector.<Unit>=new Vector.<Unit>();
		private static var unitsB:Vector.<Unit>=new Vector.<Unit>();
		
		public static function addUnit(unit:Unit):void
		{
			switch(unit.team)
			{
				case 0:
					unitsA.push(unit);
					break;
				case 1:
					unitsB.push(unit);
					break;
			}
		}
		
		public static function removeUnit(unit:Unit):void
		{
			switch(unit.team)
			{
				case 0:
					unitsA.splice(unitsA.indexOf(unit),1);
					break;
				case 1:
					unitsB.splice(unitsB.indexOf(unit),1);
					break;
			}
		}
		
		public static function getUnits(team:int):Vector.<Unit>
		{
			switch(team)
			{
				case 0:
					return unitsA;
				case 1:
					return unitsB;
			}
			return null;
		}
	}
}