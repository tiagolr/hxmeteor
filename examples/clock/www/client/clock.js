(function (console) { "use strict";
var Client = function() { };
Client.main = function() {
	Meteor.setInterval(function() {
		Session.set("time",new Date());
	},1000);
	Template.body.helpers({ hours : (function($this) {
		var $r;
		var _g = [];
		{
			var _g1 = 0;
			while(_g1 < 12) {
				var i = _g1++;
				_g.push(i);
			}
		}
		$r = _g;
		return $r;
	}(this)), degrees : function() {
		return 30 * this;
	}, handData : function() {
		var time = Session.get("time");
		if(time == null) time = new Date();
		return { hourDegrees : time.getHours() * 30, minuteDegrees : time.getMinutes() * 6, secondDegrees : time.getSeconds() * 6};
	}, radial : function(angleDegrees,startFraction,endFraction) {
		var r = 100;
		var radians = (angleDegrees - 90) / 180 * Math.PI;
		return { x1 : r * startFraction * Math.cos(radians), y1 : r * startFraction * Math.sin(radians), x2 : r * endFraction * Math.cos(radians), y2 : r * endFraction * Math.sin(radians)};
	}});
};
Client.main();
})(typeof console != "undefined" ? console : {log:function(){}});
