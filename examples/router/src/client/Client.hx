import js.Browser;
import model.Tasks;
import templates.PageTwo;
import meteor.Meteor;
import meteor.Template;
import meteor.Session;

class Client {
    static function main() {
        Shared.init();
		Meteor.subscribe('tasks');

		// PageTwo.init();

		// when using haxe its trickier to expose collections as global variables
		// a solution is to assign them to window object so they can be accessed from the console.
		untyped Browser.window['tasks'] = untyped Tasks.collection._collection;
    }
}
