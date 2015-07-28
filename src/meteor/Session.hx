package meteor;

/**
 * Session
 * @author TiagoLr
 */
@:native('Session')
extern class Session{
	static function setDefault(key:String, value:Dynamic):Void;
	static function set(key:String, value:Dynamic):Void;
	static function get(key:String):Dynamic;
	static function equals(key:String, value:Dynamic):Bool;
}