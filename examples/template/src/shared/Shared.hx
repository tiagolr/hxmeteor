import meteor.Meteor;
import meteor.Collection;
import model.Tasks;

class Shared {

    static public function init() {
		Tasks.init();
		AppRouter.init();
    }
}
