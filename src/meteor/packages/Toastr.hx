package meteor.packages;

@:enum abstract ToastrPosition(String) {
	var TOP_RIGHT 			= 'toast-top-right';
	var TOP_LEFT 			= 'toast-top-left';
	var TOP_CENTER 			= 'toast-top-center';
	var TOP_FULL_WIDTH 		= 'toast-top-full-width';
	var BOTTOM_RIGHT 		= 'toast-bottom-right';
	var BOTTOM_LEFT 		= 'toast-bottom-left';
	var BOTTOM_CENTER 		= 'toast-bottom-center';
	var BOTTOM_FULL_WIDTH 	= 'toast-bottom-full-width';
}



@:native('toastr')
extern class Toastr {
	
	static function success(msg:String, ?title:String):Void;
	static function info(msg:String, ?title:String):Void;
	static function warning(msg:String, ?title:String):Void;
	static function error(msg:String, ?title:String):Void;
	static function clear():Void;
	
	static var options: {
		?closeButton: Bool,
		?debug: Bool,
		?newestOnTop: Bool,
		?progressBar: Bool,
		?positionClass: ToastrPosition,
		?preventDuplicates: Bool,
		?onclick: Dynamic,
		?showDuration: Int,
		?hideDuration: Int,
		?timeOut: Int,
		?extendedTimeOut: Int,
		?showEasing: String,
		?hideEasing: String,
		?showMethod: String,
		?hideMethod: String
	};
}

