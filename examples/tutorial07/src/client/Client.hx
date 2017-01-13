import meteor.Meteor;

import meteor.Template;
import meteor.Session;
import meteor.ReactiveDict;

import model.Tasks;
import ui.Task;

class Client {

	public static function main() {

		Tasks.init();
		Task.init();

		Template.body.onCreated(function boo() {
			// this.state = new ReactiveDict();
			// this doesn't work with Haxe, this is the Haxe way to generate a var on the fly
			Reflect.setField(TemplateCtx, 'state', new ReactiveDict() );
			// untyped __js__('this.state = {0}', new ReactiveDict()); // this works as well
		});

		Template.body.helpers( {
			tasks: function() {
				var instance = Template.instance();
				 if (instance.state.get('hideCompleted')) {
					// If hide completed is checked, filter tasks
					return Tasks.collection.find({ checked: { '$ne': true } }, { sort: { createdAt: -1 } });
				}
				// Otherwise, return all of the tasks
				return Tasks.collection.find({}, { sort: { createdAt: -1 } });
			},
			incompleteCount: function () {
    			return Tasks.collection.find({ checked: { '$ne': true } }).count();
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
		  	},
		  	'change .hide-completed input': function (event, instance) {
		  		instance.state.set('hideCompleted', event.target.checked);
  			}

		});

		// when using haxe its trickier to expose collections as global variables
		// a solution is to assign them to window object so they can be accessed from the console.
		// untyped Browser.window['tasks'] = untyped Tasks.collection._collection;

	}

}
