import meteor.packages.Router;

/**
 * ...
 * @author TiagoLr
 */
class AppRouter {

	static public function init() {
		Router.configure( {
			layoutTemplate:'main',
			loadingTemplate:'loading',
		});
		
		Router.route("/", function() {
			RouterCtx.redirect('/one');
		});
		
		Router.route("/one", function() {
			RouterCtx.render("pageone");
		});
		
		Router.route("/two", function() {
			RouterCtx.render("pagetwo");
		});
	}
	
}