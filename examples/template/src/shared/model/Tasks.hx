package model;
import meteor.Collection;

/**
 * ...
 * @author TiagoLr
 */
class Tasks {

	public static var collection:Collection;
	public static function init() {
		collection = new Collection("Tasks");
	}
	
}