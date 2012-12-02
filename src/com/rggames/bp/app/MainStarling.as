package com.rggames.bp.app
{
	import com.rggames.bp.net.NetCode;
	import com.rggames.bp.world.entities.buildings.Building;
	import com.rggames.bp.world.entities.buildings.Resource;
	import com.rggames.bp.world.entities.buildings.Spawner;
	import com.rggames.bp.world.entities.buildings.Spawner1;
	import com.rggames.bp.world.entities.buildings.Spawner2;
	import com.rggames.bp.world.entities.buildings.Spawner3;
	import com.rggames.bp.world.entities.buildings.Throne;
	import com.rggames.bp.world.entities.units.Unit;
	import com.rggames.bp.world.entities.units.UnitManager;
	import com.rggames.bp.world.maps.Map;
	import com.rggames.bp.world.players.Player;
	
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class MainStarling extends Sprite
	{	
		public static const BUILDING_RESOURCE:String="resource";
		public static const BUILDING_SPAWNER1:String="spawner1";
		public static const BUILDING_SPAWNER2:String="spawner2";
		public static const BUILDING_SPAWNER3:String="spawner3";
		public static const GAME_STATE_PLANING:String="planing";
		public static const GAME_STATE_RUNNING:String="running";
		
		public static var starlingInstance:Starling;
		public static var instance:MainStarling;
		
		private var _gameState:String=GAME_STATE_PLANING;
		public var turnTimer:Timer=new Timer(1000,10);
		public var currRound:int=0;
		public var currentPlayer:int=0;
		
		public var map:Map=new Map();
		public var playerA:Player=new Player(0);
		public var playerB:Player=new Player(1);
		public var buildings:Array=new Array();
		
		public var buildingType:String;
		public var buildingToPlace:Building;
		public var makePathSpawner:Spawner;
		private var netCode:NetCode;
		
		private var pressedKeys:Dictionary=new Dictionary();
		
		public function MainStarling()
		{
			instance=this;
			
			playerA.throne=new Throne(0);
			playerB.throne=new Throne(1);
			addChild(map);
			
			addChild(playerA.throne);
			
			addChild(playerB.throne);
			
			Configs.thronePos=13;
			Configs.mapWidth=700;
			Configs.mapHeight=700;
			Configs.resourcePerTurn=10;
			Configs.resourcePerBuilding=1;
			Configs.maxUnitsPerSpawn=0;
			
			addEventListener(TouchEvent.TOUCH,mouseMove);
			
			addEventListener(Event.ADDED_TO_STAGE,addedToStage);
			
			Controller.initNetConnection();
		}
		
		private function addedToStage(evt:Event):void
		{
			starlingInstance.dispatchEvent(evt);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keypressed);
			stage.addEventListener(KeyboardEvent.KEY_UP,keyreleased);
		}
		
		public function getPlayer(team:int):Player
		{
			if(team)
				return playerB;
			else
				return playerA;
		}
		
		public function passTurn():void
		{
			turnTimer.addEventListener(TimerEvent.TIMER_COMPLETE,onTurnTimerComplete);
			
			if(gameState==GAME_STATE_PLANING)
			{
				getPlayer(currentPlayer).resource+=Configs.resourcePerTurn;
				
				for each(var build:Building in buildings)
				{
					if(build is Resource && build.team==currentPlayer)
					{
						getPlayer(currentPlayer).resource+=Configs.resourcePerBuilding*build.level;
					}
				}
				
				getPlayer(currentPlayer).moved=true;
				
				currentPlayer=int(!currentPlayer);
				
				if(playerA.moved&&playerB.moved)
				{
					gameState=GAME_STATE_RUNNING;
					
					if(Configs.mixedTurns)
						currentPlayer=int(!currentPlayer);
					
					var runDur:Number=Configs.runDuration;
					for(var i:int=0;i<currRound;i++)
					{
						runDur*=1+Configs.increaseRunDuration/100;
					}
					currRound++;
					turnTimer.repeatCount=runDur;
					turnTimer.start();
					
					for each(var building:Building in buildings)
					{
						building.start();
					}
					
					for each(var unit:Unit in UnitManager.getUnits(0))
					{
						unit.start();
					}
					
					for each(unit in UnitManager.getUnits(0))
					{
						unit.start();
					}
				}
				unplaceBuilding();
			}
		}
		private function onTurnTimerComplete(evt:TimerEvent):void
		{
			gameState=GAME_STATE_PLANING;
			playerA.moved=false;
			playerB.moved=false;
			turnTimer.reset();
			
			for each(var building:Building in buildings)
			{
				building.stop();
			}
			
			for each(var unit:Unit in UnitManager.getUnits(0))
			{
				unit.stop();
			}
			
			for each(unit in UnitManager.getUnits(1))
			{
				unit.stop();
			}
		}
		
		private function getBuilding(buildingType:String,level:int):Building
		{
			switch(buildingType)
			{
				case BUILDING_RESOURCE:
				{
					return new Resource(currentPlayer,level);
				}
				case BUILDING_SPAWNER1:
				{
					return new Spawner1(currentPlayer,level);
				}
				case BUILDING_SPAWNER2:
				{
					return new Spawner2(currentPlayer,level);
				}
				case BUILDING_SPAWNER3:
				{
					return new Spawner3(currentPlayer,level);
				}
			}
			return null;
		}
		
		public function setRallyPoints(buildingId:int,player:int,points:Array):void
		{
			for each(var building:Building in buildings)
			{
				if(building.id==buildingId)
				{
					var spawner:Spawner=building as Spawner;
					spawner.lines.removePoints();
					for each(var p:Point in points)
					{
						spawner.lines.addPoint(new Point(p.x-spawner.x,p.y-spawner.y),spawner);
					}
					break;
				}
			}
		}
		
		public function placeBuilding(buildingType:String,player:int,level:int,id:int,px:Number,py:Number):void
		{
			var building:Building=getBuilding(buildingType,level);
			building.x=px;
			building.y=py;
			building.team=player;
			building.id=id;
			addChild(building);
			buildings.push(building);
		}
		
		public function prePlaceBuilding(buildingType:String,level:int):void
		{
			if(!getPlayer(currentPlayer).remote) {
				if(gameState!=GAME_STATE_PLANING)
					return;
			
				this.buildingType=buildingType;
				var building:Building=getBuilding(buildingType,level);
				building.alpha=.75;
				addChild(building);
				building.team=currentPlayer;
				buildingToPlace=building;
			}
		}
		public function unplaceBuilding():void
		{
			if(buildingToPlace)
			{
				removeChild(buildingToPlace);
			}
			buildingToPlace=null;
		}
		public function upgradeBuilding(player:int,buildingType:String):void
		{
			/*if(gameState!=GAME_STATE_PLANING)
				return;
			
			switch(buildingType)
			{
				case BUILDING_RESOURCE:
				{
					if(Resource.lvl[player]<10)
						Resource.lvl[player]++;
					break;
				}
				case BUILDING_SPAWNER1:
				{
					if(Spawner1.lvl[player]<10)
						Spawner1.lvl[player]++;
					break;
				}
			}*/
		}
		
		public function mouseMove(evt:TouchEvent):void
		{
			var touch:Touch=evt.touches[0];
			var px:Number=touch.globalX;
			var py:Number=touch.globalY;
			if(px<map.width && py<map.height)
			{
				if(buildingToPlace)
				{
					buildingToPlace.x=px;
					buildingToPlace.y=py;
					if(currentPlayer?px>map.width*(py/map.height):px<map.width*(py/map.height) && buildingToPlace.cost<=getPlayer(currentPlayer).resource)
					{
						buildingToPlace.alpha=.75;
						switch(touch.phase)
						{
							case TouchPhase.HOVER:
							{
								break;
							}
							case TouchPhase.BEGAN:
							{
								getPlayer(currentPlayer).resource-=buildingToPlace.cost;
								
								var level:int=buildingToPlace.level;
								Controller.sendMessage(currentPlayer,Controller.PLACE_BUILDING_ACTION,{id:int(Math.random()*int.MAX_VALUE),buildingType:buildingType,level:level,x:px,y:py});
								unplaceBuilding();
								if(pressedKeys[Keyboard.SHIFT])
									prePlaceBuilding(buildingType,level);
								break;
							}
						}
					}
					else
					{
						buildingToPlace.alpha=.15;
					}
				}
				else if(makePathSpawner)
				{
					switch(touch.phase)
					{
						case TouchPhase.BEGAN:
						{
							makePathSpawner.lines.removePoints();
							break;
						}
						case TouchPhase.MOVED:
						{
							makePathSpawner.lines.addPoint(new Point(px-makePathSpawner.x,py-makePathSpawner.y),makePathSpawner);
							break;
						}
						case TouchPhase.ENDED:
						{
							Controller.sendMessage(currentPlayer,Controller.SET_RALLY_POINT_ACTION,{id:makePathSpawner.id,points:makePathSpawner.lines.lines});
							
							makePathSpawner=null;
							break;
						}
					}
				}
			}
		}
		private function keypressed(evt:KeyboardEvent):void
		{
			pressedKeys[evt.keyCode]=true;
		}
		private function keyreleased(evt:KeyboardEvent):void
		{
			pressedKeys[evt.keyCode]=false;
			
			if(evt.keyCode==Keyboard.SHIFT)
			{
				unplaceBuilding();
			}
		}
		
		public function get gameState():String
		{
			return _gameState;
		}
		public function set gameState(value:String):void
		{
			_gameState = value;
		}
	}
}