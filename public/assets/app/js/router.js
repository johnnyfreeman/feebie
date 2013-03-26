'use strict';

FF.Router = Marionette.AppRouter.extend({

  appRoutes: {
		'':      'displaySearch',
		'help':  'displayHelp',
		':code': 'lookUpCode'
  },

	// update google analytics
  navigate: function(fragment, options) {
  	_gaq.push(['_trackPageview', fragment]);
	  return Marionette.AppRouter.prototype.navigate.call(this, fragment, options);
	}

});