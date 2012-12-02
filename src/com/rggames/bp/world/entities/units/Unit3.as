package com.rggames.bp.world.entities.units
{
	import com.rggames.bp.app.Configs;
	import com.rggames.bp.app.MainStarling;
	import com.rggames.bp.world.entities.Entity;
	
	import flash.geom.Point;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;

	public class Unit3 extends Unit
	{
		[Embed(source="assets/unitA3.png")]
		private static var imageA:Class;
		[Embed(source="assets/unitB3.png")]
		private static var imageB:Class;
		
		public var aoe:int;
		
		public function Unit3(side:int,lvl:Number)
		{
			super();
			level=lvl;
			switch(level)
			{
				case 1:
					power=Configs.unit3Dmg1;
					aoe=Configs.unit3AOE1;
					break;
				case 2:
					power=Configs.unit3Dmg2;
					aoe=Configs.unit3AOE2;
					break;
				case 3:
					power=Configs.unit3Dmg3;
					aoe=Configs.unit3AOE3;
					break;
				case 4:
					power=Configs.unit3Dmg4;
					aoe=Configs.unit3AOE4;
					break;
				case 5:
					power=Configs.unit3Dmg5;
					aoe=Configs.unit3AOE5;
					break;
			}
			team=side;
			
			setImageByTeam(imageA,imageB,level,1.7,false);
		}
		
		public override function set power(value:int):void
		{
			var p1:int=_power;
			
			_power = value;
			if(power<=0)
			{				
				var todmg:Array=new Array();
				
				for each(var unit:Entity in UnitManager.getUnits(int(!team)))
				{
					if(Point.distance(new Point(x,y),new Point(unit.x,unit.y))<aoe)
					{
						todmg.push(unit);
					}
				}
				
				for each(var unit2:Entity in todmg)
				{
					unit2.power-=p1;
				}
				
				destroy();
			}
		}
		
		protected override function damageTarget(target:Entity):void
		{
			var p1:int=power;
			var p2:int=target.power;
			power-=p2;
			target.power-=p1;
		}
	}
}