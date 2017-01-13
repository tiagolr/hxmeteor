import meteor.Meteor;
import meteor.Error;

import model.Tasks;

class Server {

	public static function main() {
		Shared.init();

		Meteor.methods({
			'tasks.insert': function (text:String) {
				Check.check(text, String);

				// Make sure the user is logged in before inserting a task
				if (MethodCtx.userId == null) {
					throw new Error('not-authorized');
				}

				Tasks.collection.insert({
					text: text,
					createdAt: Date.now(), // current time
					owner: Meteor.userId(),
					username: Meteor.users.findOne(MethodCtx.userId).username,
				});
			},
			'tasks.remove': function (taskId:String) {
				Check.check(taskId, String);

				Tasks.collection.remove(taskId);
			},
			'tasks.setChecked': function (taskId:String, setChecked:Bool) {
				Check.check(taskId, String);
				Check.check(setChecked, Bool);

				Tasks.collection.update(taskId, { '$set': { checked: setChecked } });
			}
		});

	}
}