package meteor;
import haxe.Constraints.Function;

typedef FindOneOptions = {
	?sort:Dynamic,
	?skip:Int,
	?fields:Dynamic<Int>,
}

typedef FindOptions = {
	?sort:Dynamic,
	?skip:Int,
	?limit:Int,
	?fields:Dynamic<Int>,
}

typedef UpdateOptions = {
	?multi:Bool,
	?upsert:Bool,
	
	// requires collections2 package
	?validationContext:String,
	?validate:Bool, 
	?getAutoValues:Bool,
	?removeEmptyStrings:Bool,
	?autoConvert:Bool,
	?filter:Bool,
}

typedef InsertOptions = {
	// requires collections2 package
	?validationContext:String,
	?validate:Bool, 
	?getAutoValues:Bool,
	?removeEmptyStrings:Bool,
	?autoConvert:Bool,
	?filter:Bool,
}

typedef AllowOptions = {
	@:optional function insert(userid:String, doc:Dynamic):Bool; // userid->document
	@:optional function update(userid:String, doc:Dynamic, fields:Array<String>, modifier:Dynamic):Bool;
	@:optional function remove(userid:String, doc:Dynamic):Bool;
	@:optional var fetch:Array<String>;
}

typedef CollectionOptions = {
	?connection: { },
	?idGeneration:String, // 'STRING' or 'MONGO'
}

typedef CollectionHooks = {
	/** userId -> document */
	function insert(f:Dynamic) : Void;
	/** userId -> document -> fields -> modifier -> options */
	function update(f:Dynamic, ? fetch: { fetchPrevious:Bool } ) : Void;
	/** userId -> document */
	function remove(f:Dynamic) : Void;
	/** userId, selector, modifier, option */
	function upsert(f:Dynamic) : Void;
	/** userId, selector, options, cursor(after only) */
	function find(f:Dynamic) : Void;
	/** userId, selector, options, doc(after only) */
	function findOne(f:Dynamic) : Void;
}

/**
 * Collections
 * @author TiagoLr
 */
@:native('Mongo.Collection')
extern class Collection {

	function new(name:String, ?options:CollectionOptions);
	function findOne(?selector: Dynamic, ?options:FindOneOptions):Dynamic;
	function find(?selector: Dynamic, ?options: FindOptions ):Cursor;
	
	@:overload(function(doc:Dynamic, ?opts:InsertOptions, ?callback: Dynamic->String->Void ):String { } ) // requires collections2
	@:overload(function(doc:Dynamic, ?opts:InsertOptions, ?callback: Dynamic->Void ):String { } ) // requires collections2
	@:overload(function(doc:Dynamic, ?callback: Dynamic->Void ):String { } )
	function insert(doc:Dynamic, ?callback: Dynamic->String->Void ):String;
	
	@:overload(function(selector:Dynamic, modifier:Dynamic, ?options:UpdateOptions, ?callback:Dynamic->Void):String{})
	function update(selector:Dynamic, modifier:Dynamic, ?options:UpdateOptions, ?callback:Dynamic->String->Void):Void;
	function upsert(selector:Dynamic, modifier:Dynamic, ?options:UpdateOptions, ?callback:Dynamic->String->Void):Void; 
	function remove(selector:Dynamic, ?callback:Dynamic->Void):Dynamic;
	function allow(options:AllowOptions):Void;
	function deny(options:AllowOptions):Void;
	
	/** requires collection-hooks package */
	var before : CollectionHooks;
	/** requires collection-hooks package */
	var after : CollectionHooks;
	/** requires collection-hooks package */
	var direct : CollectionHooks;
	/** requires collection-hooks package */
	var hookOptions : {
		before: CollectionHooks,
		after: CollectionHooks,
		insert: CollectionHooks,
	};
	
}