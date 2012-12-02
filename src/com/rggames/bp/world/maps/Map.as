package com.rggames.bp.world.maps
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class Map extends Sprite
	{
		[Embed(source="assets/bg.png")]
		private static var image:Class;
		
		public function Map()
		{
			super();
			
			var img:Image= new Image(Texture.fromBitmap(new image()));
			addChild(img);
		}
	}
}