package meteor;
import haxe.Constraints.Function;
import haxe.extern.Rest;
import haxe.extern.EitherType;

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

typedef User = {
	username:String,
	emails:Array<{address:String,verified:Bool}>,
	createdAt:Date,
	profile: Dynamic,
	services: Dynamic,
	?roles: {}, 	// requires `Roles` package.
}

typedef ExternalLoginOpts = {
	requestPermissions:Array<String>,
	requestOfflineToken:Bool,
	loginUrlParameters: { },
	userEmail:String,
	loginType:String, // 'popup' or 'redirect'
	redirectUrl:String,
}

@:native('Meteor')
extern class Meteor {

	static var isClient(default,null):Bool;
	static var isServer(default, null):Bool;
	static var isCordova(default, null):Bool;
	static var settings(default, null): Dynamic;
	static var release(default, null):String;

	static function startup(cb:Void->Void):Void;
	static function wrapAsync(cb:Dynamic->Void, ?ctx:Dynamic):Void;
	static function absoluteUrl(?path:String, ?options: { ?secure:Bool, replaceLocalhost:Bool, rootUrl:Bool } ):String;
	static function publish(name:String, func:Dynamic):Dynamic;
	static function subscribe(name:String, args:Rest<Dynamic>): {stop:Void->Void, ready:Void->Void};
	static function methods(methods: Dynamic<Function> ):Void;
	static function call(name:String, args:Rest<Dynamic>):Void;
	static function apply(name:String, ?args:Array<Dynamic>, ?options:ApplyOptions, ?callback:Dynamic->Dynamic->Void):Void;

	// connections
	static function status():Status;
	static function reconnect():Void;
	static function disconnect():Void;
	static function onConnect(callback:OnConnect->Void):Void;

	// timers
	static function setTimeout(callback:Void->Void, delay:Int):Int;
	static function setInterval(callback:Void->Void, delay:Int):Int;
	static function clearTimeout(id:Int):Void;
	static function clearInterval(id:Int):Void;

	// accounts
	static function user():User;
	static function userId():Null<String>;
	static var users:Collection;
	static function loggingIn():Bool;
	static function logout(?callback:EitherType<Void->Void, Error->Void>):Void;
	static function logoutOtherClients(?callback:EitherType<Void->Void, Error->Void>):Void;

	// requires aditional packages accounts-password, accounts-facebook, etc...
	static function loginWithPassword(user:EitherType<User,String>, password:String, callback:EitherType<Void->Void, Error->Void>):Void;
	static function loginWithFacebook(opts:ExternalLoginOpts, callback:EitherType<Void->Void, Error->Void>):Void;
	static function loginWithGithub(opts:ExternalLoginOpts, callback:EitherType<Void->Void, Error->Void>):Void;
	static function loginWithGoogle(opts:ExternalLoginOpts, callback:EitherType<Void->Void, Error->Void>):Void;
	static function loginWithTwitter(opts:ExternalLoginOpts, callback:EitherType<Void->Void, Error->Void>):Void;
	static function loginWithWeibo(opts:ExternalLoginOpts, callback:EitherType<Void->Void, Error->Void>):Void;
	static function loginWithMeetup(opts:ExternalLoginOpts, callback:EitherType<Void->Void, Error->Void>):Void;

}

@:native('this')
extern class PublishCtx {

	static var userId(default, null):String;
	static var connection(default, null):Dynamic;
	static function added(collection:String, id:String, fields: { } ):Void;
	static function changed(collection:String, id:String, fields: { } ):Void;
	static function removed(collection:String, id:String):Void;
	static function ready():Void;
	static function onStop(callback:Void->Void):Void;
	static function error(err:Error):Void;
	static function stop():Void;
}

@:native('this')
extern class MethodCtx {
	static var userId(default, null):String;
	var connection(default, null):Dynamic;
	static function setUserId(?userId:String):Void;
	static var isSimulation(default, null):Bool;
	static var unBlock(default, null):Bool;
}

// 'meteor add check'
// http://stackoverflow.com/questions/33521059/check-is-not-defined-in-meteor-js
@:native('check')
extern class Check {
	@:selfCall public static function check(value:Dynamic, pattern:Dynamic):Void;
}

@:native('Match')
extern class Match {
	static function test(value:Dynamic, pattern:Dynamic):Bool;

	static function ObjectIncluding( keys:{ } ):Void;
	static function Optional(pattern:Dynamic):Void;
	static function OneOf(pattern:Rest<Dynamic>):Void;
	static function Where(condition:Dynamic->Bool):Void;

	static var Any(default, null):Dynamic;
	static var Integer(default, null):Dynamic;



	// [mck] little hack for consitancy
	@:native('Integer') static var Int;
	// @:native('String') static var String;
	// @:native('Number') static var Number;
	// @:native('Boolean') static var Boolean;
	// @:native('Boolean') static var Bool;
	// @:native('undefined') static var undefined;
	// static var null():String return untyped null;


}

@:native('DDP')
extern class DDP {
	static function connect(url:String):Dynamic; // TODO DDP callback object
}
