var JsConsoleHelper = (function() {

	var helper = {};
	
	helper.openGlobalConfig = function() {	
		var cmd = 'cd "${TM_BUNDLE_SUPPORT}"; mate jsconsole_config.yaml',
				myCommand = TextMate.system(cmd);
		myCommand.onreadoutput = function(str) { console.log("read: " + str); };
		myCommand.onreaderror = function(str) { console.log("error: " + str); };
	};
	
	helper.openProjectConfig = function() {
		var cmd = 'cd "${TM_PROJECT_DIRECTORY:-$TM_DIRECTORY}"; mate jsconsole_config.yaml',
				myCommand = TextMate.system(cmd);
		myCommand.onreadoutput = function(str) { console.log("read: " + str); };
		myCommand.onreaderror = function(str) { console.log("error: " + str); };
	};
	
	return helper;
	
})();