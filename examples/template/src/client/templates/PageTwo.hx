package templates;
import meteor.Template;
import model.Tasks;

/**
 * ...
 * @author TiagoLr
 */
class PageTwo {

	public static function init() {

		Template.get('pagetwo').helpers( {
			tasks: function() {
				return Tasks.collection.find();
			}
		});

		Template.get('pagetwo').events( {

			"submit .new-task": function (event) {
				event.preventDefault();
				var text = event.target.text.value;

				// Insert a task into the collection
				Tasks.collection.insert({
					text: text,
					createdAt: Date.now() // current time
				});

				// Clear form
				event.target.text.value = "";
			},


			"click .btn-danger": function (event) {
				Tasks.collection.find().forEach(function(entry) {
					Tasks.collection.remove(untyped entry._id);
				});
			}

		});

	}
}