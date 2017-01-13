package meteor;

import haxe.Constraints.Function;

/**
 * ReactiveVar
 * @author Matthijs
 */
@:native('ReactiveVar')
extern class ReactiveVar{

	public function new(initialValue:Dynamic, ?equalsFunc:Function);

	static function set(key:String, value:Dynamic):Void;
	static function get(key:String):Dynamic;

}