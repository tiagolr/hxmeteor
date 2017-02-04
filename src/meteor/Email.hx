package meteor;

import haxe.Constraints.Function;
import haxe.extern.EitherType;
import meteor.Meteor.User;

typedef MailComposer = {
	function addHeader(name:String, value:String):Void;
	function setMessageOption(from:String, to:String, body:String, html:String):Void;
	function streamMessage():Void;
	function pipe(stream:Dynamic):Void;
};

typedef EmailOptions = {
	var from : String;
	@:optional var to : EitherType<String, Array<String>>;
	@:optional var cc : EitherType<String, Array<String>>;
	@:optional var bcc : EitherType<String, Array<String>>;
	@:optional var replyTo : EitherType<String, Array<String>>;
	@:optional var subject : String;
	@:optional var text : String;
	@:optional var html : String;
	@:optional var headers : Dynamic;
	@:optional var attachments : Array<Dynamic>;
	@:optional var mailComposer : MailComposer;
}


/**
 * Email
 *
 * `meteor add email`
 *
 * @author Matthijs
 */
@:native('Email')
extern class Email {
	static function send(options:EmailOptions):Void;
}
