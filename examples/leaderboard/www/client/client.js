(function (console) { "use strict";
var Client = function() { };
Client.main = function() {
	Shared.init();
	Template.leaderboard.helpers({ players : function() {
		return Shared.players.find({ },{ sort : { score : -1, name : 1}});
	}, selectedName : function() {
		var player = Shared.players.findOne(Session.get("selectedPlayer"));
		if(player != null) return player.name; else return null;
	}});
	Template.leaderboard.events({ 'click .inc' : function() {
		Shared.players.update(Session.get("selectedPlayer"),{ '$inc' : { score : 5}});
	}});
	Template.player.helpers({ selected : function() {
		if(Session.equals("selectedPlayer",this._id)) return "selected"; else return "";
	}});
	Template.player.events({ 'click' : function() {
		Session.set("selectedPlayer",this._id);
	}});
};
var Shared = function() { };
Shared.init = function() {
	Shared.players = new Mongo.Collection("players");
};
Client.main();
})(typeof console != "undefined" ? console : {log:function(){}});
