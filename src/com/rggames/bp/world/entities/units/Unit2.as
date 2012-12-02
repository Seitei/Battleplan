package com.rggames.bp.world.entities.units
{
	import com.rggames.bp.app.Configs;
	
	import flash.geom.Point;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;

	public class Unit2 extends Unit
	{
		[Embed(source="assets/unitA2.png")]
		private static var imageA:Class;
		[Embed(source="assets/unitB2.png")]
		private static var imageB:Class;
		
		public function Unit2(side:int,lvl:Number)
		{
			super();
			level=lvl;
			switch(level)
			{
				case 1:
					power=Configs.unit2Dmg1;
					break;
				case 2:
					power=Configs.unit2Dmg2;
					break;
				case 3:
					power=Configs.unit2Dmg3;
					break;
				case 4:
					power=Configs.unit2Dmg4;
					break;
				case 5:
					power=Configs.unit2Dmg5;
					break;
			}
			team=side;
			
			setImageByTeam(imageA,imageB,level,1.1,false);
		}
	}
}