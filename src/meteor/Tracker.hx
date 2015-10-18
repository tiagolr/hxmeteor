package meteor;
import haxe.Constraints.Function;

/**
 * ...
 * @author TiagoLr
 */
@:native("Tracker")
extern class Tracker {
	static function autorun(runFun:Function, ?onError:Function):Void;
}
