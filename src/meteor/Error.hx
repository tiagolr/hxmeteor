package meteor;

/**
 * Error
 * @author TiagoLr
 */
@:native('Meteor.Error')
extern class Error extends js.Error{

	public function new(error:Dynamic, ?reason:String, ?details:String) {}
	
	var error(default, null):Dynamic;
	var reason(default, null):String;
	var details(default, null):String; 	 
	var errorType(default, null):String;
	
}