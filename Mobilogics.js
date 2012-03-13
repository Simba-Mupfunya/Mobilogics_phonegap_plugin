/**
 * Constructor
 **/
function Mobilogics () {
	
}

/**
 * Installization
 **/
Mobilogics.install = function () {
	if (!navigator.plugins)
		navigator.plugins = {};
	if (!navigator.plugins.Mobilogics)
		navigator.plugins.Mobilogics = new Mobilogics();
}

/**
 * Add to PhoneGap constructor
 **/
Cordova.addConstructor(Mobilogics.install);

/**
 * Functions interface
 **/
Mobilogics.prototype.start = function () {
	PhoneGap.exec(null, null, "Mobilogics", "start");
}

Mobilogics.prototype.stop = function () {
	PhoneGap.exec(null, null, "Mobilogics", "stop");
}

Mobilogics.prototype.scan = function (successCallback) {
	PhoneGap.exec(successCallback, null, "Mobilogics", "scan");
}

Mobilogics.prototype.addConnectionListener = function (connectedCallback, disconnectedCallback) {
	PhoneGap.exec(connectedCallback, disconnectedCallback, "Mobilogics", "addConnectionListener");
}