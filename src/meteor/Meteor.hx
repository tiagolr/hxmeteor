package meteor;
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.extern.Rest;

typedef ApplyOptions = {
	wait:Bool,
	onResultReceived:Dynamic->Void
}

typedef Status = {
	connected:Bool,
	status:String,
	retryCount:Int,
	?retryTime:Int,
	?reason:String,
}

typedef OnConnect = {
	id:String,
	close: Void->Void,
	onClose: Void->Void,
	clientAddress:String,
	httpHeaders:Dynamic
}

@:native('Meteor')
extern class Meteor {
	static var isClient(default,null):Bool;
	static var isServer(default, null):Bool;
	static var isCordova(default, null):Bool;
	static var settings(default, null): { };
	static var release(default, null):String;
	
	static function startup(cb:Void->Void):Void;
	static function wrapAsync(cb:Dynamic->Void, ?ctx:Dynamic):Void;
	static function absoluteUrl(?path:String, ?options: { ?secure:Bool, replaceLocalhost:Bool, rootUrl:Bool } ):String;
	static function publish(name:String, func:Void->Dynamic):Dynamic;
	
	// Subscribe to a record set. Returns a handle that provides stop() and ready() methods.
	static function subscribe(name:String, ?arg1:Dynamic, ?arg2:Dynamic, ?arg3:Dynamic, ?arg4:Dynamic, ?callback:Dynamic): {stop:Void->Void, ready:Void->Void};
	
	// METHODS
	/**
	 * Dictionary whose keys are method names and values are functions.
	 * @param m 	Methods should return a JSON response or throw an error.
	 */
	static function methods(m: { } ):Void;
	
	/**
	 * represents a symbolic error thrown by a method.
	 */
	@:native('Error')
	static function Error(error:String, ?reason:String, ?details:String):Void;
	
	/**
	 * Invokes a method passing any number of arguments.
	 */
	static function call(name:String, ?arg1:Dynamic, ?arg2:Dynamic, ?arg3:Dynamic, ?arg4:Dynamic, ?asyncCallback:Dynamic->Void):Dynamic;
	
	/**
	 * Invoke a method passing an array of arguments.
	 */
	static function apply(name:String, args:Array<Dynamic>, ?options:ApplyOptions, ?asyncCallback:Dynamic->Void):Dynamic;
	
	// CONNECTIONS
	static function status():Status;
	static function reconnect():Void;
	static function disconnect():Void;
	static function onConnect(callback:OnConnect->Void):Void;
	@:native('DDP.connect')
	static function connect(url:String):Dynamic;  // TODO DDP callback
	
	// TIMMERS
	static function setTimeout(callback:Void->Void, delay:Int):Int;
	static function setInterval(callback:Void->Void, delay:Int):Int;
	static function clearTimeout(id:Int):Void;
	static function clearInterval(id:Int):Void;
	
	// ACCOUNTS
	// static function user
	// static function userId
	// static function users
	// static function loggingIn
	// static function logout
	// static function logoutOtherClients
	// static function loginWithPassword
	// static function loginWith<Service>
	
}

@:native('check')
extern class Check {
	@:selfCall public function check(value:Dynamic, pattern:Dynamic):Void;
}

extern class Match {
	static function test(value:Dynamic, pattern:Dynamic):Bool;
	
	static function ObjectIncluding( keys:{ } ):Void;
	static function Optional(pattern:Dynamic):Void;
	static function OneOf(pattern:Rest<Dynamic>):Void;
	static function Where(condition:Dynamic->Bool):Void;
	
	static var Any(default, null):Dynamic;
	static var Integer(default, null):Dynamic;
}

@:native('this')
extern class PublishCtx {
	
	// The id of the logged-in user, or null if no user is logged in.
	var userId(default, null):String;
	
	// The incoming connection for this subscription.
	var connection(default, null):Dynamic;
	
	// Informs the subscriber that a document has been added to the record set.
	function added(collection:String, id:String, fields: { } ):Void;
	
	// Informs the subscriber that a document in the record set has been modified.
	function changed(collection:String, id:String, fields: { } ):Void;
	
	// Informs the subscriber that a document has been removed from the record set.
	function removed(collection:String, id:String):Void;
	
	// Informs the subscriber that an initial, complete snapshot of the record set has been sent. 
	// This will trigger a call on the client to the onReady callback passed to Meteor.subscribe, if any.
	function ready():Void;
	
	// Registers a callback function to run when the subscription is stopped.
	function onStop(callback:Void->Void):Void;
	
	// Stops this client's subscription, triggering a call on the client to the onStop callback passed to Meteor.subscribe, if any.
	// If error is not a Meteor.Error, it will be sanitized.
	function error(err:Error):Void;
	
	// Stops this client's subscription and invokes the client's onStop callback with no error.
	function stop():Void;
}

@:native('this')
extern class MethodCtx {
	// The id of the user that made this method call, or null if no user was logged in.
	static var userId(default, null):String;
	
	// The incoming connection for this subscription.
	var connection(default, null):Dynamic;
	
	// Set the logged in user.
	static function setUserId(?userId:String):Void;
	
	// Boolean value, true if this invocation is a stub.
	static var isSimulation(default, null):Bool;
	
	// Allow subsequent method from this client to begin running in a new fiber.
	static var unBlock(default, null):Bool;
}