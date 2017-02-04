import meteor.Meteor;

import meteor.Template;
import meteor.Session;
import meteor.ReactiveDict;

import model.Tasks;
import startup.AccountsConfig;

class Client {

	public static function main() {

		Shared.init();

		AccountsConfig.init();

		ui.Task.init();


		Template.body.onCreated(function() {
			// this.state = new ReactiveDict();
			// there is no way to generate a var on the fly with Haxe,
			// read: https://blog.meteor.com/the-meteor-chef-reactive-dict-reactive-vars-and-session-variables-971584515a27#.shog0r3qo
			Session.set('hideCompleted', false );
		});

		Template.body.helpers( {
			tasks: function() {
				var instance = Template.instance();
				if (Session.get('hideCompleted')) {
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
					createdAt: Date.now(), // current time
					owner: Meteor.userId(),
					username: Meteor.user().username
				});

				// Clear form
				target.text.value = '';
			},
			'change .hide-completed input': function (event) {
				Session.set('hideCompleted', event.target.checked);
				var isHideCompleted : Bool = Session.get('hideCompleted');
				// trace(isHideCompleted);
				// this.state.set('hideCompleted', event.target.checked);
			}

		});

		// when using haxe its trickier to expose collections as global variables
		// a solution is to assign them to window object so they can be accessed from the console.
		// untyped Browser.window['tasks'] = untyped Tasks.collection._collection;

	}

}
