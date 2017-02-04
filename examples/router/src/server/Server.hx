import meteor.Meteor;
import model.Tasks;

class Server {
    static function main() {
        Shared.init();
		
		Meteor.publish('tasks', function () {
			return Tasks.collection.find();
		});
    }
}
