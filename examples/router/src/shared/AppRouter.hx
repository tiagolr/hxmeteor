import meteor.packages.IronRouter;

import js.Browser.*;

/**
 * ...
 * @author TiagoLr
 */
class AppRouter {

	static public function init() {

		IronRouter.configure( {
			layoutTemplate:'main',
			loadingTemplate:'loading',
		});

		IronRouter.route("/faq", function() {
			console.log("faq");
			RouterCtx.redirect('/help');
		});

		IronRouter.route("/", function() {
			RouterCtx.render('/home');
		});

		IronRouter.route("/settings", function() {
			RouterCtx.render("settings");
		});

		IronRouter.route("/profile", function() {
			RouterCtx.render("profile");
		});

		IronRouter.route("/help", function() {
			RouterCtx.render("help");
		});

		// http://www.manuel-schoebel.com/blog/iron-router-tutorial
		IronRouter.route("/post/:_id", {
			template: 'post',
			data: function(){
        		// code goes here
				var params = RouterCtx.params;
				var id = params._id;
				console.log('id: $id'); // "5"
				console.log(RouterCtx.params); // { _id: "5" }
				var _data = {
					_id : id,
					test : 'foobar'
				};
				return _data;
    		}
		});

		/*
		IronRouter.route("/post/:_id", function() {
			var params = RouterCtx.params;
			var id = params._id;
			console.log('id: $id'); // "5"
			console.log(RouterCtx.params); // { _id: "5" }
			RouterCtx.render("post");
		});
		*/


	}

}