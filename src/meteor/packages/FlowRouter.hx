package meteor.packages;
import haxe.Constraints.Function;

typedef RouteOptions = {
	?name:String, 
	?triggersEnter:Array<Dynamic>,
	?triggersExit:Array<Dynamic>,
	?action: Function,
}

typedef RouteObject = {
	path:String,
	params: Dynamic<String>,
	queryParams:Dynamic<String>,
	route: Dynamic,
	oldRoute:Dynamic,
}

@:native('FlowRouter')
extern class FlowRouter {
	
	static var subscriptions:Function;
	static var triggers: { enter:Function, exit:Function };
	
	static function group(?opts:Dynamic):Dynamic; // todo group options
	static function getParam(name:String):Dynamic;
	static function getQueryParam(queryStr:String):Dynamic;
	static function path(pathDef:String, ?params: { }, ?queryParams: { } ):String;
	static function route(path:String, opts:RouteOptions):Dynamic;
	static function go(pathDef:String, ?params: { }, ?queryParams: { } ):Void;
	static function setParams(newParams: { } ):Void;
	static function setQueryParams(newQueryParams: { } ):Void;
	static function getRouteName():String;
	static function current():RouteObject;
	static function watchPathChange():Void;
	static function withReplaceState(fn:Void->Void):Void;
	static function reload():Void;
	static function wait():Void;
	static function initialize():Void;
	static function onRouteRegister(cb:Dynamic->Void):Void;
	static function subsReady(?name:String, ?cb:Void->Void):Bool;
	
	static var notFound:RouteOptions;
}

