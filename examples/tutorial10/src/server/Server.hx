import meteor.Meteor;
import meteor.Error;

import model.Tasks;

class Server {

	public static function main() {
		Shared.init();

		if (Meteor.isServer) {

			// This code only runs on the server
			// Only publish tasks that are public or belong to the current user
			Meteor.publish('tasks', function tasksPublication() {
				return Tasks.collection.find({
					'$or': [
						{ 'private': { '$ne': true } },
						{ 'owner': PublishCtx.userId },
					],
				});
			});

			// // This code only runs on the server
			// Meteor.publish('tasks', function tasksPublication() {
			// 	return Tasks.collection.find();
			// });
		}

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
			},
			'tasks.setPrivate': function (taskId:String, setToPrivate:Bool) {
				Check.check(taskId, String);
				Check.check(setToPrivate, Bool);

				var task = Tasks.collection.findOne(taskId);

				// Make sure only the task owner can make a task private
				if (task.owner != MethodCtx.userId) {
				  	throw new Error('not-authorized');
				}

				Tasks.collection.update(taskId, { '$set': { 'private': setToPrivate } });
			},
		});

	}
}