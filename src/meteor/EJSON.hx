package meteor;

import haxe.Constraints.Function;
import haxe.extern.EitherType;
import haxe.Json;

typedef StringifyOptions = {
	@:optional var indent : EitherType<Bool, EitherType<Float, String>>;
	@:optional var canonical : Bool;
}

typedef EqualsOptions = {
	@:optional var keyOrderSensitive : Bool;
}

/**
 * EJSON
 *
 * @source   	http://docs.meteor.com/api/ejson.html
 *
 * @author Matthijs
 */
@:native('EJSON')
extern class EJSON {

	static function parse(str:String):EJSON;
	static function stringify(val:EJSON, ?options:StringifyOptions):String;

	static function fromJSONValue(val:Json):EJSON;
	static function toJSONValue(val:EJSON):Json;

	static function equals(a:EJSON, b:EJSON, ?options:EqualsOptions):Bool;
	// static function clone<T>(val:T):T;
	// static var newBinary : Dynamic;
	// static function addType(name:String, factory:JSONable -> EJSONableCustomType):Void;
	// static function isBinary(x:Dynamic):Bool;

}
