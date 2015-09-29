package meteor.packages;
import haxe.ds.StringMap;
import meteor.Collection;
import haxe.extern.EitherType;

/**
 * A simple, reactive schema validation package for Meteor. 
 * It's used by the Collection2 and AutoForm packages, but you can use it by itself, too.
 * 
 * https://github.com/aldeed/meteor-collection2
 */
typedef SchemaField = {
	type: Dynamic,
	?label: String,
	?labels: {},
	?optional: Bool,
	?min: Int,
	?max: Int,
	?exclusiveMin:Bool,
	?exclusiveMax:Bool,
	?decimal:Bool,
	?minCount:Int,
	?maxCount:Int,
	?allowedValues: Array<String>,
	?regEx: Dynamic,
	?blackbox: Bool,
	?trim:Bool,
	?defaultValue:Dynamic,
	?autoValue:Dynamic,
	?custom:Void->Void,
	
	// Requires collections2 package
	?denyInsert:Bool,
	?denyUpdate:Bool,
	?index: EitherType<Int,Bool>,
	?unique:Bool,
	
	// Requires autoform package
	?autoform: {}
}
typedef SchemaDef = Dynamic<SchemaField>;

typedef AttachSchemaOptions = {
	// If your validation requires that your doc be transformed using the 
	// collection's transform function prior to being validated, 
	// then you must pass the transform: true option to attachSchema when you attach the schema:
	?transform:Bool,
	
	// By default, if a collection already has a schema attached, attachSchema will combine 
	// the new schema with the existing. Pass the replace: true option to attachSchema to 
	// discard any existing schema.
	?replace:Bool,
}

typedef CleanOptions = {
	?filter:Bool,
	?autoConvert:Bool,
	?removeEmtpyStrings:Bool,
	?trimStrings:Bool,
	?getAutoValues:Bool, 
	?isModifier:Bool, 
	?extendAutoValueContext:{}
}

@:native('SimpleSchema')
extern class SimpleSchema {
	
	static var RegEx(default,null): {
		Email:String,
		Domain:String,
		WeakDomain:String,
		IP:String,
		IPV4:String,
		IPV6:String,
		Url:String,
		Id:String,
		ZipCode:String,
	};
	
	static var debug:Bool;
	
	function new(schema:SchemaDef);
	static function extendOptions(opts: { } ):Void;
	
	@:native('messages')
	static function messages_(messages:Dynamic<String>):Void;
	
	function pick(values:Array<String>):Dynamic;
	function label(fieldName:String):String;
	function clean(obj: { }, ?options: CleanOptions ):Void;	
	function schema(?keys:Array<String>): { };
	function messages(messages:Dynamic<String>):Void;
	
	// Requires collections2 package
	static inline function attachSchema(collection:Collection, schema:SimpleSchema, options:AttachSchemaOptions ):Dynamic {
		return untyped collection.attachSchema(schema, options);
	}
}

@:native('this')
extern class SchemaCtx {
	static var isSet(default, null):Bool;
	static var value(default, null):Dynamic;
	static var operator(default, null):String;
	static function field(name:String):Dynamic;
	static function siblingField(name:String):Dynamic;
	static function unset():Void;
	
	// Requires collections2 package
	static var isInsert:Bool;
	static var isUpdate:Bool;
	static var isUpsert:Bool;
	static var userId:String;
	static var isTrustedFromCode:Bool;
	static var docId:String;
}

extern class Match {
	static function test(obj:{}, schema:SimpleSchema):Bool;
}