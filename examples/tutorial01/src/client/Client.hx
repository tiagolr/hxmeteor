import meteor.Meteor;

import meteor.Session;
import meteor.Template;

import meteor.ReactiveVar;

class Client {

	public static function main() {

		Template.get('hello').onCreated(function helloOnCreated() {
			// counter starts at 0
			Template.instance().counter = new ReactiveVar(0);
		});

		Template.get('hello').helpers({
			counter: function () {
    			return Template.instance().counter.get();
  			},
		});

		Template.get('hello').events({
			'click button': function () {
			    // increment the counter when button is clicked
    			Template.instance().counter.set(Template.instance().counter.get() + 1);
			}
		});
	}

}
