import meteor.Meteor;

import meteor.Template;
import model.Tasks;
import ui.Task;


class Client {

	public static function main() {

		Tasks.init();
		Task.init();

		Template.body.helpers( {
			tasks: function() {
				// return Tasks.collection.find({});
				// Show newest tasks at the top
				return Tasks.collection.find({}, { sort: { createdAt: -1 } });
			}
		});


		Template.body.events( {
			'submit .new-task': function(event) {
				// Prevent default browser form submit
				event.preventDefault();

				// Get value from form element
				var target = event.target;
				var text = target.text.value;

				// Insert a task into the collection
				Tasks.collection.insert({
					text: text,
					createdAt: Date.now() // current time
			    });

			    // Clear form
			    target.text.value = '';
		  	}

		});

		// when using haxe its trickier to expose collections as global variables
		// a solution is to assign them to window object so they can be accessed from the console.
		// untyped Browser.window['tasks'] = untyped Tasks.collection._collection;

	}

}
