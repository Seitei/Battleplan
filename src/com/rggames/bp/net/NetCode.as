package com.rggames.bp.net
{
	import com.rggames.bp.app.Controller;
	import com.rggames.bp.app.MainStarling;
	
	import flash.net.Responder;

	public class NetCode
	{
		import flash.display.SimpleButton;
		import flash.display.Sprite;
		import flash.events.Event;
		import flash.events.EventDispatcher;
		import flash.events.NetStatusEvent;
		import flash.events.StatusEvent;
		import flash.geom.Point;
		import flash.net.GroupSpecifier;
		import flash.net.NetConnection;
		import flash.net.NetGroup;
		import flash.net.NetStream;
		import flash.net.registerClassAlias;
		import flash.utils.ByteArray;
		import flash.utils.Dictionary;
		import flash.utils.Timer;
		import flash.utils.getTimer;
		
		registerClassAlias("Point", Point);
		
		private const SERVER:String = "rtmfp://p2p.rtmfp.net/"; 
		private const DEVKEY:String = "cde41fe05bb01817e82e5398-2ab5d983d09f"; 
		private const NAME:String = "Artemix";
		
		private var _cirrusNc:NetConnection;
		private var _amfphpNc:NetConnection;
		
		private var _connected:Boolean = false;
		
		private var _user:String;
		
		private var _status:String;
		private var _controller:Controller;
		
		private static var _sendStream:NetStream;
		private var _receivingStream:NetStream;
		
		private var _res:Responder;
		private static var _instance:NetCode;
		private var _receiving:Boolean;
		
		[Bindable]
		public var logs:String = "Output\r";
		
		public function NetCode():void {
			connect();	
		}
		
		public function connect():void
		{
			_status = "waiting";
			_cirrusNc = new NetConnection(); 
			_cirrusNc.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus); 
			_cirrusNc.connect( SERVER + DEVKEY );
		}
		
		public function onResult(response:Object):void {
			
			//here we ask if there is another player waiting to connect to someone
			if(response == "waiting") {
				//just wait
				MainStarling.instance.playerA.remote = false;
				MainStarling.instance.playerB.remote = true;
				
			}
				//if not:
			else {
				MainStarling.instance.playerA.remote = true;
				MainStarling.instance.playerB.remote = false;
				connectToPeer(response[1]);
				
				
			}
		}
		
		public function onFault(response:Object):void {
			for (var i:* in response) {
				trace(response[i]);
			}
		}
		
		private function onNetStatus(event:NetStatusEvent):void {
			
			switch(event.info.code){
				case "NetConnection.Connect.Success":
					trace(event.info.code);
					onCirrusConnect();
					break;
				case "NetStream.Play.Start":
					trace(event.info.code);
					break;
				case "NetStream.Connect.Success":
					trace(event.info.code);
					if(!_connected){
						_connected = true;
						onPeerConnect(event.info.stream.farID);
					}
				default:
					trace(event.info.code);
				
			}
			logs += event.info.code + "\r";
		}
		
		public function send(player:int,action:int,data:Object=null):void {
			_sendStream.send("handler", player, action, data);
		}
		
		private function onCirrusConnect():void {
			//connecting to amfphp
			_amfphpNc = new NetConnection();
			//_amfphpNc.connect("http://localhost/Amfphp/");
			_amfphpNc.connect("http://tecnocort.com.ar/project/amfphp/Amfphp/");
			_res = new Responder(onResult, onFault);
			_amfphpNc.call("Rendezvous.match", _res, NAME, _cirrusNc.nearID);
			
			//defining the send stream
			_sendStream = new NetStream(_cirrusNc, NetStream.DIRECT_CONNECTIONS);	
			_sendStream.client = this;
			_sendStream.publish("data");
		}
		
		private function connectToPeer(farID:String):void {
			
			_connected = true;
			
			//defining the receiving stream
			_receivingStream = new NetStream(_cirrusNc, farID);	
			_receivingStream.client = this;
			_receivingStream.play("data");
		}
		
		private function onPeerConnect(farID:String):void {
			
			//defining the receiving stream
			_receivingStream = new NetStream(_cirrusNc, farID);	
			_receivingStream.client = this;
			_receivingStream.play("data");
		}
		
		public function handler(player:int, action:int, data:Object=null):void {
			Controller.receiveMessage(player, action, data);
		}
		
		public static function getInstance():NetCode {
			if(!_instance){
				_instance = new NetCode();
			}
			return _instance;
		}
		
	}
}