package meteor;

typedef FindOneOptions = {
	?sort:Dynamic,
	?skip:Int,
	?fields:Dynamic,
}

typedef FindOptions = {
	?sort:Dynamic,
	?skip:Int,
	?limit:Int,
	?fields:Dynamic,
}

typedef UpdateOptions = {
	?multi:Bool,
	?upsert:Bool,
}

typedef AllowOptions = {
	// userid->document
	?insert : (String->Dynamic)->Bool,
	
	// userid->document->fieldNames->modifier
	?update : (String->Dynamic->Array<String>->Dynamic)->Bool,
	
	// userid->document
	?remove : (String->Dynamic)->Bool
}

typedef CollectionOptions = {
	?connection: { },
	?idGeneration:String, // 'STRING' or 'MONGO'
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
	function insert(doc:Dynamic, ?callback: (Dynamic->String)->Void ):String;
	function update(selector:Dynamic, modifier:Dynamic, ?options:UpdateOptions, ?callback:(Dynamic->String)->Void):Void;
	function remove(selector:Dynamic, ?callback:Dynamic->Void):Dynamic;
	
	/**
	 * Once you have removed the insecure package, use the allow and deny methods to control who can perform which operations on the database. 
	 * By default, all operations on the client are denied, so we need to add some allow rules.
	 */
	function allow(options:AllowOptions):Void;
	
	/**
	 * The deny method lets you selectively override your allow rules. 
	 * While only one of your allow callbacks has to return true to allow a modification, 
	 * every one of your deny callbacks has to return false for the database change to happen.
	 */
	function deny(options:AllowOptions):Void;
	
}