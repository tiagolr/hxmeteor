package ui;

import meteor.Meteor;
import meteor.Template;

import model.Tasks;

class Task {

	public static function init() {

		Template.get('task').events( {

			'click .toggle-checked': function (event : Dynamic) {
				// Set the checked property to the opposite of its current value
				var isChecked : Bool = event.target.checked;
				// Tasks.collection.update(TemplateCtx._id, {
				// 	'$set': { checked: isChecked }
				// });

				// Set the checked property to the opposite of its current value
				Meteor.call('tasks.setChecked', TemplateCtx._id, isChecked);

			},
			'click .delete': function () {
				// Tasks.collection.remove(TemplateCtx._id);
				Meteor.call('tasks.remove', TemplateCtx._id);
			}
		});

	}
}
