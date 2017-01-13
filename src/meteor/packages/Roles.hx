package meteor.packages;

import haxe.extern.EitherType;

@:native('Roles')
extern class Roles {

	static var GLOBAL_GROUP(default, null):String;

	static function addUsersToRoles(userId:String, roles:EitherType<String, Array<String>>, ?group:String):Void;
	static function userIsInRole(userId:String, roles:EitherType<String, Array<String>>, ?group:String):Bool;
	static function setUserRoles(userId:String, roles:Array<String>, ?group:String):Void;

}