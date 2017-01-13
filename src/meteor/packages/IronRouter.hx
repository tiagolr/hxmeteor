package meteor.packages;

import haxe.Constraints.Function;
import haxe.io.Path;

/**
 * Meteor Iron:Router externs
 * https://github.com/iron-meteor/iron-router
 *
 * @author TiagoLr
 */
typedef RouterConfigs = {
	?layoutTemplate:String,
	?loadingTemplate:String,
	?template:String,
	?controller:Dynamic,
	?waitOn:Dynamic,
}

typedef RouteOptions = {
	?name:String,
	?controller:String,
	?template:String,
	?layoutTemplate:String,
	?yieldRegions: { },
	?subscriptions:Void->Void,
	?waitOn: { },
	?data:Void->Void,
	?onRun: Void->Void,
	?onRerun: Void->Void,
	?onBeforeAction: Void->Void,
	?onAfterAction: Void->Void,
	?onStop: Void->Void,
	?action: Void->Void,
	?where:String,  // 'server' or 'client'
}

@:native('Router')
extern class IronRouter {

	static var routes:Dynamic; // access named routes

	static function configure(configs: RouterConfigs ):Void;

	@:overload(function(path:String, ?opts:RouteOptions):Void{})
	static function route(path:String, cb:Dynamic, ?opts:RouteOptions):Dynamic; // TODO return Route with get,set and post methods

	static function go(path:String, ?params: { }, ?opts: { ?query:String, ?hash:String } ):Void;
	static function onBeforeAction(cb:Void->Void):Void;
	static function onRerun(cb:Void->Void):Void;
	static function before(f:Dynamic, ?params: { } ):Void;
	static function current():RouterInstance;

	/*static inline function controller():RouteController {
		return untyped __js__('this');
	}*/
	static function controller():Dynamic;
}

extern class RouterInstance {
	public var route:Dynamic;
	//function getName():String;
}

@:native('this')
extern class RouterCtx {
	static function extend(?opts: RouteOptions):Dynamic;

	static var params:Dynamic; 		// nodejs params object
	static var request:Dynamic; 	// nodejs request object
	static var response:Dynamic;	// nodejs response object

	inline static function query():Dynamic {return untyped params.query;}
	inline static function hash():Dynamic { return untyped params.hash;}
	static function layout(name:String):Void;
	static function redirect(path:String):Void;
	static function render(layoutName:String, ?options: { ?to:String, data:Void->Dynamic } ):Void;
	static function stop():Void;
}