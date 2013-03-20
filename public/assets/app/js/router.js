'use strict';

FF.Router = Marionette.AppRouter.extend({

  appRoutes: {
    '':      'displaySearch',
    'help':  'displayHelp',
    ':code': 'lookUpCode'
  }

});