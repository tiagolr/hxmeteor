import meteor.Meteor;

import model.Tasks;

class Shared {

	static public function init() {
		Tasks.init();
	}
}
