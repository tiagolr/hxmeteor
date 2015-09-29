package meteor.packages;
import meteor.Cursor;

typedef CountOpts = {
	?noReady:Bool,
	?nonReactive:Bool,
	?countFromField:Dynamic,
	?countFromFieldLength:Dynamic,
	?noWarnings:Bool,
}

@:native('Counts')
extern class PublishCounts {
	public static function publish(subscription:Dynamic, counterName:String, cursor:Cursor, ?options:CountOpts):Dynamic;
	public static function get(counterName:String):Int;
	public static function has(counterName:String):Bool;
	public static function noWarnings():Void; // [server] disables development warnings
	
}