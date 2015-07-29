(function (console) { "use strict";
var AppRouter = function() { };
AppRouter.init = function() {
	Router.configure({ layoutTemplate : "main", loadingTemplate : "loading"});
	Router.route("/",function() {
		this.redirect("/one");
	});
	Router.route("/one",function() {
		this.render("pageone");
	});
	Router.route("/two",function() {
		this.render("pagetwo");
	});
};
var Server = function() { };
Server.main = function() {
	Shared.init();
	Meteor.publish("tasks",function() {
		return model_Tasks.collection.find();
	});
};
var Shared = function() { };
Shared.init = function() {
	model_Tasks.init();
	AppRouter.init();
	if(model_Tasks.collection.find().count() == 0) {
	}
};
var model_Tasks = function() { };
model_Tasks.init = function() {
	model_Tasks.collection = new Mongo.Collection("Tasks");
};
Server.main();
})(typeof console != "undefined" ? console : {log:function(){}});
