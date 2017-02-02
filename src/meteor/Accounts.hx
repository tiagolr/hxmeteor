package meteor;
import haxe.Constraints.Function;
import haxe.extern.EitherType;
import meteor.Meteor.User;


typedef CreateUserOptions = {
	?username:String,
	?email:String,
	password:String, // required on the client
	?profile:{},
}

typedef EmailFields = {
	from: Void->String,
	subject: Dynamic->String,		// userProfile->String
	?text: Dynamic->String->String, // userProfile->url->String
	?html: Dynamic->String->String,	// userProfile->url->String

}

typedef EmailTemplate = {
	from:String,
	siteName:String,
	headers: { },
	resetPassword: EmailFields,
	enrollAccount: EmailFields,
	verifyEmail: EmailFields,
}

typedef LoginOptions = {
	type:String,
	allowed:Bool,
	error: Dynamic,
	user: User,
	connection: Dynamic,
	methodName: String,
	methodArguments: Array<Dynamic>,
}


typedef UIConfig = {
	?requestPermissions: { },
	?requestOfflineToken: { },
	?forceApprovalPrompt: { },
	?passwordSignupFields: PasswordSignupFields,

	// requires accounts-ui-bootstrap-3 package
	?forceEmailLowercase: Bool,
    ?forceUsernameLowercase: Bool,
    ?forcePasswordLowercase: Bool,
	?extraSignupFields: ExtraSignupFields,
}

typedef ExtraSignupFields = {
	?fieldName:String,
	?fieldLabel: String,
	?showFieldLabel:Bool,
	?inputType: String, // text, radio etc...
	?data:Dynamic, // for radios and selects
	?empty:String, // placeholder text
	?visible: Bool,
	?saveToProfile:Bool,
	?validate:Dynamic->Dynamic->Bool,
}

@:enum abstract PasswordSignupFields(String) {
	var USERNAME_AND_EMAIL = 'USERNAME_AND_EMAIL';
    var USERNAME_AND_OPTIONAL_EMAIL = 'USERNAME_AND_OPTIONAL_EMAIL';
    var USERNAME_ONLY = 'USERNAME_ONLY';
	var EMAIL_ONLY = 'EMAIL_ONLY'; // default
}

/**
 * Accounts
 *
 * http://docs.meteor.com/api/passwords.html
 *
 * The accounts-password package contains a full system for password-based authentication.
 * In addition to the basic username and password-based sign-in process,
 * it also supports email-based sign-in including address verification and password recovery emails.
 *
 * `meteor add accounts-password`
 *
 * @author TiagoLr
 */
@:native('Accounts')
extern class Accounts {

	// client and server
	static function onLogin(func: Dynamic->Void):Void;
	static function onLoginFailure(func:Dynamic->Void):Void;

	static var emailTemplates: EmailTemplate;
	static var config: {
		sendVerificationMail:Bool,
		forbidClientAccountCreation:Bool,
		restrictCreationByEmailDomain:EitherType<String, Function>,
		loginExpirationDays:Int,
		oAuthSecretKey:String,
	};

	// client only
	static function loggingIn():Bool;
	static function logout(?callback:EitherType<Void->Void, Error->Void>):Void;
	static function logoutOtherClients(?callback:EitherType<Void->Void, Error->Void>):Void;

	// server only
	static function onCreateUser(func:Dynamic->User->User):Void;
	static function validateNewUser(func:User->Bool):Void;
	static function validateLoginAttempt(func:LoginOptions->Bool):Void;


	// requires accounts-password package
	// `meteor add accounts-password`
	static function createUser(options:CreateUserOptions, ?callback:EitherType<Void->Void, Error->Dynamic>):String;
	static function setUserName(userId:String, username:String):Void;
	static function addEmail(userId:String, newEmail:String, ?verified:Bool):Void;
	static function removeEmail(userId:String, email:String):Void;
	static function verifyEmail(token:String, ?callback:EitherType<Void->Void, Error->Dynamic>):Void;
	static function findUserByUsername(username:String):Dynamic;
	static function findUserByEmail(email:String):Dynamic;
	static function changePassword(oldPassword:String, newPassword:String, ?callback:EitherType<Void->Void, Error->Dynamic>):Void;
	static function forgotPassword(email:String, ?callback:EitherType<Void->Void, Error->Dynamic>):Void;
	static function resetPassword(token:String, newPassword:String, ?callback:EitherType<Void->Void, Error->Dynamic>):Void;
	static function setPassword(userId:String, newPassword:String, ?options:{logout:Bool}):Void;
	static function sendResetPasswordEmail(userId:String, ?email:String):Void;
	// static function setResetPassword(userId:String, ?email:String):Void;
	static function sendEnrollmentEmail(userId:String, ?email:String):Void;
	static function sendVerificationEmail(userId:String, ?email:String):Void;
	static function onResetPasswordLink(callback:String->Dynamic->Void):Void;
	static function onEnrollmentLink(callback:String->Dynamic->Void):Void;
	static function onEmailVerificationLink(callback:String->Dynamic->Void):Void;

	// requires accounts-ui package
	static var ui: { config:UIConfig->Void};
	// static var ui: { config:UIConfig};
}
