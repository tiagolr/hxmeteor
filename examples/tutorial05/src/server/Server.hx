import meteor.Meteor;

import model.Tasks;

class Server {

	public static function main() {

		Tasks.init();
	}
}
