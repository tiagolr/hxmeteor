package ui;

import meteor.Meteor;
import meteor.Template;

import model.Tasks;

class Task {

	public static function init() {

		Template.get('task').helpers({
			isOwner: function() {
				// this.owner
				// here we go again... not possible in Haxe, so hack it!
				// The nice way
				// var _temp = Reflect.field(TemplateCtx,'owner');
				// trace(_temp);
				var _owner = untyped __js__('this.owner');
				// trace(_owner);
				return _owner == Meteor.userId();
			}
		});

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
			},
			'click .toggle-private': function () {
				// here we go again... not possible in Haxe, so hack it!
				// var _temp = Reflect.field(TemplateCtx,'private');
				// trace(_temp);
				var _private = untyped __js__('this.private');
				// trace(_private);
    			Meteor.call('tasks.setPrivate', TemplateCtx._id, !_private);
  			}
		});

	}
}
