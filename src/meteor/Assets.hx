package meteor;

import haxe.Constraints.Function;
import haxe.extern.EitherType;

/**
 * Assets
 *
 * @author Matthijs
 */
@:native('Assets')
extern class Assets {
	static function getBinary(assetPath:String, ?asyncCallback:Function):EJSON;
	static function getText(assetPath:String, ?asyncCallback:Function):String;
	static function absoluteFilePath(assetPath:String):String;
	static function getBinary(assetPath:String, ?asyncCallback:Function):EJSON;
	static function getText(assetPath:String, ?asyncCallback:Function):String;
	static function absoluteFilePath(assetPath:String):String;
}

