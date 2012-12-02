package com.rggames.bp.world.entities.buildings
{
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;

	public class Throne extends Building
	{
		[Embed(source="assets/throneA.png")]
		private static var imageA:Class;
		[Embed(source="assets/throneB.png")]
		private static var imageB:Class;
		
		public function Throne(team:int)
		{
			super();
			power=1000;
			this.team=team
			
			setImageByTeam(imageA,imageB);
		}
	}
}