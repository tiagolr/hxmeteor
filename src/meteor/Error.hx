package meteor;

/**
 * Error
 * @author TiagoLr
 */
@:native('Meteor.Error')
extern class Error{

	public function new(code:Int, msg:String) {}
	
}