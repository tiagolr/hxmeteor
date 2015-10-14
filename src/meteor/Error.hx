package meteor;

/**
 * Error
 * @author TiagoLr
 */
@:native('Meteor.Error')
extern class Error{

	public function new(error:Dynamic, ?reason:String, ?details:String) {}
	
	var error(default, null):Dynamic;
	var reason(default, null):String;
	var message(default, null):String; 
	var details(default, null):String; 	 
	var errorType(default, null):String;
	
	/**
	 * Utility function to throw meteor errors without wrapping them with haxe constructors.
	 * If the error is thrown from the server without default js throw, the error will always reach the client 
	 * as 500 Internal Server Error.
	 * 
	 * @param	error
	 * @return
	 */
	static inline function throw_(error:Dynamic):Dynamic {
		return new NativeThrow(error);
	}
	
}

@:native('throw')
extern class NativeThrow {
    @:selfCall public function new(error:Dynamic);
}