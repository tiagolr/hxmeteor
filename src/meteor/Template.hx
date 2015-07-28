package meteor;
import haxe.ds.Either;
import js.html.Element;

/**
 * Template
 * @author TiagoLr
 */
@:native('Template')
extern class Template {
	
	// The template object representing your <body> tag.
	static var body:Template;
	
	/**
	 * Fetches template object from name.
	 */
	inline static function get(template:String):Template {
		return untyped Template[template];
	}
	
	static function instance():Dynamic;
	static function registerHelper(name:String, helper:Void->Void):Void;
	static function currentData():Dynamic;
	static function parentData(?numLevels:Int):Void;
	
	function onRendered(callback:Void->Void):Void;
	function helpers(helpers: { } ):Void;
	function events(eventMap: { } ):Void;
	function onCreated(callback:Void->Void):Void;
	function onDestroyed(callback:Void->Void):Void;
}

@:native('this')
extern class TemplateCtx {
	
	static var _id(default, null):String;
	static var firstNode(default, null):Element;
	static var lastNode(default, null):Element;
	static var data(default, null): { };
	static var view(default, null): Dynamic;
	
	static function findAll(selector:String):Array < Element >;
	
	// BUG - returning JQuery in findAllAsJquery causes server to crash when importing Template
	//		 a solution for now is to cast the return value to Jquery manually
	@:native('$')
	static function findAllAsJQuery(selector:String):Dynamic; 
	
	static function find(selector:String):Element;
	static function autorun(runFunc:Void->Void):Void;
	static function subscribe(name:String, ?a1:Dynamic, ?a2:Dynamic, ?a3:Dynamic, ?a4:Dynamic, ?callbacks:Dynamic):Void;
}