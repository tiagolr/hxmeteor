import meteor.Meteor;

class Server {
    static function main() {
        Shared.init();

        Meteor.startup(function() {
            if (Shared.players.find().count() == 0) {
                var names = ["Ada Lovelace", "Grace Hopper", "Marie Curie",
                             "Carl Friedrich Gauss", "Nikola Tesla", "Claude Shannon"];

                for (name in names) {
                    Shared.players.insert({
                        name: name,
                        score: Math.floor(Math.random() * 10) * 5
                    });
                }
            }
        });
    }
}
