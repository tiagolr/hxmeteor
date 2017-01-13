import meteor.Meteor;

class Server {

	public static function main() {

		if (Meteor.isServer) {
			Meteor.startup(function () {
				// code to run on server at startup
			});
		}
	}
}
