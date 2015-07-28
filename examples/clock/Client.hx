import meteor.Meteor;
import meteor.Session;
import meteor.Template;

class Client {
    static function main() {

        Meteor.setInterval(function() {
            Session.set('time', Date.now());
        }, 1000);

        Template.body.helpers({

            hours: [for(i in 0...12) i],

            degrees: function() {
                return 30 * js.Lib.nativeThis;
            },

            handData: function () {
                var time:Date = Session.get('time');
                if (time == null) time = Date.now();

                return { hourDegrees: time.getHours() * 30,
                         minuteDegrees: time.getMinutes() * 6,
                         secondDegrees: time.getSeconds() * 6 };
            },

            radial: function(angleDegrees,
                             startFraction,
                             endFraction) {

                var r = 100;
                var radians = (angleDegrees-90) / 180 * Math.PI;

                return {
                  x1: r * startFraction * Math.cos(radians),
                  y1: r * startFraction * Math.sin(radians),
                  x2: r * endFraction * Math.cos(radians),
                  y2: r * endFraction * Math.sin(radians)
                };
            }

        });
    }
}
