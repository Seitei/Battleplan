package com.rggames.bp.world.entities.buildings
{
	import flash.utils.Dictionary;
	
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;

	public class Resource extends Building
	{		
		[Embed(source="assets/resource.png")]
		private static var imageA:Class;
		
		public function Resource(t:int,lvl:int)
		{
			super();
			team=t;
			level=lvl;
			setImageByTeam(imageA,imageA,level,.5);
			cost=5*level;
			power*=level;
		}
	}
}