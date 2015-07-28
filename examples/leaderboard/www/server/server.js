(function (console) { "use strict";
var Server = function() { };
Server.main = function() {
	Shared.init();
	Meteor.startup(function() {
		if(Shared.players.find().count() == 0) {
			var names = ["Ada Lovelace","Grace Hopper","Marie Curie","Carl Friedrich Gauss","Nikola Tesla","Claude Shannon"];
			var _g = 0;
			while(_g < names.length) {
				var name = names[_g];
				++_g;
				Shared.players.insert({ name : name, score : Math.floor(Math.random() * 10) * 5});
			}
		}
	});
};
var Shared = function() { };
Shared.init = function() {
	Shared.players = new Mongo.Collection("players");
};
Server.main();
})(typeof console != "undefined" ? console : {log:function(){}});
