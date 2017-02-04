package startup;

import meteor.Meteor;
import meteor.Accounts;
import meteor.Accounts.ui;

// not sure it should be here... for some reason the server doesn't need this

class AccountsConfig {

    static public function init() {
    	Accounts.ui.config({
    		passwordSignupFields : PasswordSignupFields.USERNAME_ONLY
    	});
    }
}
