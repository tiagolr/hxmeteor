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
var Client = function() { };
Client.main = function() {
	Shared.init();
	Meteor.subscribe("tasks");
	templates_PageTwo.init();
	window.tasks = model_Tasks.collection._collection;
};
var Shared = function() { };
Shared.init = function() {
	model_Tasks.init();
	AppRouter.init();
};
var model_Tasks = function() { };
model_Tasks.init = function() {
	model_Tasks.collection = new Mongo.Collection("Tasks");
};
var templates_PageTwo = function() { };
templates_PageTwo.init = function() {
	Template.pagetwo.helpers({ tasks : function() {
		return model_Tasks.collection.find();
	}});
	Template.pagetwo.events({ 'submit .new-task' : function(event) {
		event.preventDefault();
		var text = event.target.text.value;
		model_Tasks.collection.insert({ text : text, createdAt : new Date()});
		event.target.text.value = "";
	}, 'click .btn-danger' : function(event1) {
		model_Tasks.collection.find().forEach(function(entry) {
			model_Tasks.collection.remove(entry._id);
		});
	}});
};
Client.main();
})(typeof console != "undefined" ? console : {log:function(){}});
