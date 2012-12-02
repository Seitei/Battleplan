package com.rggames.bp.world.entities.units
{
	import com.rggames.bp.app.Configs;
	
	import flash.geom.Point;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;

	public class UnitA extends Unit
	{
		[Embed(source="assets/unitA.png")]
		private static var imageA:Class;
		[Embed(source="assets/unitB.png")]
		private static var imageB:Class;
		
		public function UnitA(side:int,lvl:Number)
		{
			super();
			level=lvl;
			switch(level)
			{
				case 1:
					power=Configs.unit1Dmg1;
					break;
				case 2:
					power=Configs.unit1Dmg2;
					break;
				case 3:
					power=Configs.unit1Dmg3;
					break;
				case 4:
					power=Configs.unit1Dmg4;
					break;
				case 5:
					power=Configs.unit1Dmg5;
					break;
			}
			team=side;
			
			setImageByTeam(imageA,imageB,level,1.5,false);
		}
	}
}