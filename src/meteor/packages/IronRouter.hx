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
	// The name of the route.
	// Used to reference the route in path helpers and to find a default template
	// for the route if none is provided in the "template" option. If no name is
	// provided, the router guesses a name based on the path '/post/:_id'
	?name:String, 
	
	// If we want to provide a specific RouteController instead of an anonymous one we can do that here.
	?controller:String,
	
	// If the template name is different from the route name you can specify it 
	// explicitly here.
	?template:String,
	
	// A layout template to be used with this route.
	// If there is no layout provided, a default layout will
	// be used.
	?layoutTemplate:String,
	
	// A declarative way of providing templates for each yield region
	// in the layout
	?yieldRegions: { },
	
	// a place to put your subscriptions
	?subscriptions:Void->Void,
	
	// Subscriptions or other things we want to "wait" on. This also
	// automatically uses the loading hook. That's the only difference between
	// this option and the subscriptions option above.
	?waitOn: { },
	
	// A data function that can be used to automatically set the data context for
	// our layout. This function can also be used by hooks and plugins. For
	// example, the "dataNotFound" plugin calls this function to see if it
	// returns a null value, and if so, renders the not found template.
	?data:Void->Void,
	
	// You can provide any of the hook options described below in the "Using
	// Hooks" section.
	?onRun: Void->Void,
	?onRerun: Void->Void,
	?onBeforeAction: Void->Void,
	?onAfterAction: Void->Void,
	?onStop: Void->Void,
	
	// The same thing as providing a function as the second parameter. You can
	// also provide a string action name here which will be looked up on a Controller
	// when the route runs. More on Controllers later. Note, the action function
	// is optional. By default a route will render its template, layout and
	// regions automatically.
	?action: Void->Void,
	
	// 'server' or 'client'
	?where:String, 
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
	
	static var params:Dynamic; 		// nodeJs params object
	static var request:Dynamic; 	// nodeJs request object
	static var response:Dynamic;	// nodeJs response object
	
	inline static function query():Dynamic {return untyped params.query;}
	inline static function hash():Dynamic { return untyped params.hash;}
	static function layout(name:String):Void;
	static function redirect(path:String):Void;
	static function render(layoutName:String, ?options: { ?to:String, data:Void->Dynamic } ):Void;
	static function stop():Void;
}