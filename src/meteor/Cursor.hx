package meteor;

/**
 * Cursor
 * @author TiagoLr
 */
extern class Cursor{

	@:overload(function(cb:(Dynamic)->Void, ?thisArg:Dynamic):Void{})
	@:overload(function(cb:(Dynamic->Int)->Void, ?thisArg:Dynamic):Void{})
	function forEach(cb:(Dynamic->Int->Cursor)->Void, ?thisArg:Dynamic):Void;
	
	@:overload(function(cb:(Dynamic)->Void, ?thisArg:Dynamic):Array<Dynamic>{})
	@:overload(function(cb:(Dynamic->Int)->Void, ?thisArg:Dynamic):Array<Dynamic>{})
	function map(cb:(Dynamic->Int->Cursor)->Void, thisArg:Dynamic):Array<Dynamic>;
	
	function fetch():Array<Dynamic>;
	function count():Int;
	function observe(callbacks: { } ):Void;
	function observeChanges(callbacks: { } ):Void;
}