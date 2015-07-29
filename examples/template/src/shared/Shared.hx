import meteor.Meteor;
import meteor.Collection;
import model.Tasks;

class Shared {

    static public function init() {
		Tasks.init();
		AppRouter.init();
		
		// make collections available as global vars
		
		if (Tasks.collection.find().count() == 0) {
			// create stub tasks
		}
    }
}
