import meteor.Meteor;
import meteor.Template;
import meteor.Session;

class Client {
    static function main() {
        Shared.init();

        Template.get('leaderboard').helpers({
            players: function () {
                return Shared.players.find({}, {sort: { score: -1, name: 1 }});
            },
            selectedName: function () {
                var player = Shared.players.findOne(Session.get("selectedPlayer"));
                return player != null ? player.name : null;
            }
        });

        Template.get('leaderboard').events({
            'click .inc': function () {
                Shared.players.update(Session.get("selectedPlayer"), {'$inc': {score: 5}});
            }
        });

        Template.get('player').helpers({
            selected: function () {
                return Session.equals("selectedPlayer", TemplateCtx._id) ? "selected" : '';
            }
        });

        Template.get('player').events({
            'click': function () {
                Session.set("selectedPlayer", TemplateCtx._id);
            }
        });
    }
}
