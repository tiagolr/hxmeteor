import meteor.Meteor;

import meteor.Session;
import meteor.Template;

class Main {

    public static function main() {
        if (Meteor.isClient) {
            // counter starts at 0
            Session.setDefault('counter', 0);

            Template.get('hello').helpers({
                counter: function () {
                  return Session.get('counter');
                }
            });

            Template.get('hello').events({
                'click button': function () {
                  // increment the counter when button is clicked
                  Session.set('counter', Session.get('counter') + 1);
                }
            });
        }

        if (Meteor.isServer) {
            Meteor.startup(function () {
                // code to run on server at startup
            });
        }
    }
}
