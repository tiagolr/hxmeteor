(function (console) { "use strict";
var Main = function() { };
Main.main = function() {
	if(Meteor.isClient) {
		Session.setDefault("counter",0);
		Template.hello.helpers({ counter : function() {
			return Session.get("counter");
		}});
		Template.hello.events({ 'click button' : function() {
			Session.set("counter",Session.get("counter") + 1);
		}});
	}
	if(Meteor.isServer) Meteor.startup(function() {
	});
	console.log("FUCK");
};
Main.main();
})(typeof console != "undefined" ? console : {log:function(){}});
