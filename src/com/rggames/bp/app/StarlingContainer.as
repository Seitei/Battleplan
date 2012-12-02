package com.rggames.bp.app
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import starling.core.Starling;
	
	public class StarlingContainer extends Sprite
	{
		private var starlingInstance:Starling;
		
		public function StarlingContainer()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE,addedToStage);
		}
		
		private function addedToStage(evt:Event):void
		{
			starlingInstance=new Starling(MainStarling);
			starlingInstance.start();
		}
	}
}