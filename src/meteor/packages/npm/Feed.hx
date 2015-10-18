package meteor.packages.npm;

// hacky npm require
@:native('(Meteor.npmRequire("feed"))')
extern class Feed {
	function new(options:Dynamic);
}