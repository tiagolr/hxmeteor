import meteor.Meteor;
import meteor.Collection;

class Shared {
    public static var players(default, null):Collection;

    static public function init() {
        players = new Collection("players");
    }
}
