package meteor;

import haxe.Constraints.Function;
import haxe.extern.EitherType;
/**
 * ReactiveDict
 * @author Matthijs
 */
@:native('ReactiveDict')
extern class ReactiveDict{

	public function new(?dictName:EitherType<Dynamic, String>);

	static function set(key:String, value:Dynamic):Void;
	static function get(key:String):Dynamic;



	static function setDefault(key:EitherType<Dynamic, String>, value:Dynamic):Void;


	static function equals(key:String, value:Dynamic):Bool;

	static function clear():Dynamic;
	static function delete():Bool;
	static function all():Dynamic; // ?

}