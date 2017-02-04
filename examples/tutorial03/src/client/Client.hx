import meteor.Meteor;

import meteor.Template;
import model.Tasks;


class Client {

	public static function main() {

		Tasks.init();

		Template.body.helpers( {
			tasks: function() {
				return Tasks.collection.find({});
			}
		});

		// when using haxe its trickier to expose collections as global variables
		// a solution is to assign them to window object so they can be accessed from the console.
		untyped Browser.window['tasks'] = untyped Tasks.collection._collection;

	}

}
