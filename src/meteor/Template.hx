package meteor;
import haxe.Constraints.Function;
import haxe.ds.Either;
import js.html.Element;
import haxe.extern.Rest;

/**
 * Template
 * @author TiagoLr
 */
@:native('Template')
extern class Template {
	
	/** Fetches template object from name. */
	inline static function get(template:String):Template return untyped Template[template]; // TODO array access this class
	static function instance():Dynamic;
	static function registerHelper(name:String, helper:Function):Void;
	static function currentData():Dynamic;
	static function parentData(?numLevels:Int):Void;
	
	function onRendered(callback:Void->Void):Void;
	function helpers(helpers: { } ):Void;
	
	function events(eventMap: Dynamic<Dynamic->Void> ):Void;
	
	function onCreated(callback:Void->Void):Void;
	function onDestroyed(callback:Void->Void):Void;
	
	static var body:Template;
}

@:native('this')
extern class TemplateCtx {
	
	static var _id(default, null):String;
	static var firstNode(default, null):Element;
	static var lastNode(default, null):Element;
	static var data(default, null): { };
	static var view(default, null): Dynamic;
	static function findAll(selector:String):Array < Element >;
	static function find(selector:String):Element;
	static function autorun(runFunc:Void->Void):Void;
	static function subscribe(name:String, args:Rest<Dynamic>):Void;
	
	@:native('$')
	static function findAllAsJQuery(selector:String):Dynamic; // FIX - returning JQuery here causes server to crash.
}