package meteor.packages;
import haxe.Constraints.Function;
import haxe.extern.EitherType;
import meteor.Collection;
import meteor.Error;
import meteor.Template;

typedef HooksObject = {
	?before: { },
	?after: { },
	?onSubmit: Dynamic->Dynamic->Dynamic->Void, // function (insertDoc, updateDoc, currentDoc)
	?onSuccess: Dynamic->Dynamic->Void, // function (formType, result)
	?onError: Dynamic->Dynamic->Void, // function (formType, error)
	?formToDoc: Dynamic->Void, // function (doc)
	?formToModifier: Dynamic->Void, // function (modifier)
	?docToForm: Dynamic->Dynamic->Void, // function (doc, ss)
	?beginSubmit:Void->Void,
	?endSubmit:Void->Void
}

/**
 * ...
 * @author TiagoLr
 */
@:native('AutoForm')
extern class AutoForm {

	static function hooks( hooks:Dynamic<HooksObject> ):Void;
	static function addHooks( formName:EitherType<String, Array<String>>, hook:HooksObject):Void;
	static function resetForm(id:String):Void;
	static function setDefaultTemplate(template:String):Void;
	static function debug():Void;
	static function validateField(formId:String, fieldName:String, skipEmpty:Bool):Bool;
	static function templateInstanceForForm(id:String):Template;
	static function getFormValues(formId:String, ?template:Template, ?ss:SimpleSchema, ?getModifier:Bool):Dynamic;
	static function getFieldValue(fieldName:String, ?formId:String):Dynamic;
	
	// TODO create externs for whole api: https://github.com/aldeed/meteor-autoform/blob/master/api.md
}

@:native('this')
extern class HookCtx {
	static function addStickyValidationError(key:String, type:Dynamic, value:Dynamic):Void;
	static function removeStickyValidation(key:String):Void;
	static function resetForm():Void;
	static function done(?error:Error, ?success:Dynamic):Void;
	
	static var autoSaveChangedElement:Dynamic;
	static var collection:Collection;
	static var currentDoc:Dynamic;
	static var docId:String;
	static var event:Dynamic;
	static var formAttributes:Dynamic;
	static var formId:String;
	static var insertDoc:Dynamic;
	static var ss:SimpleSchema;
	static var ssIsOverride:Bool;
	static var template:Template;
	static var updateDoc:Dynamic;
	static var validationContext:Dynamic;
}