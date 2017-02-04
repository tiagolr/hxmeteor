import meteor.packages.IronRouter;

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

		IronRouter.route("/", function() {
			RouterCtx.redirect('/one');
		});

		IronRouter.route("/one", function() {
			RouterCtx.render("pageone");
		});

		IronRouter.route("/two", function() {
			RouterCtx.render("pagetwo");
		});
	}

}