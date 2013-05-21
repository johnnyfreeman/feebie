'use strict';

FF.Controller = Marionette.Controller.extend({

  // initialize: function() {

  // },

  displayHelp: function() {
    console.log('help controller called.');
  },

  displaySearch: function(options) {
    FF.mainRegion.show(new FF.Views.SearchFormItem(options));
  },

  lookUpCode: function(code) {
    var codeModel = new FF.Models.Code({code:code.toUpperCase()});
    var response = codeModel.fetch();
    response.done(function() {
      FF.mainRegion.show(new FF.Views.Code({model: codeModel}));
    });
    response.fail(_.bind(this.displayAlert, this, {
      title: 'Holy Guacamole!',
      description: 'That code cannot be found. You will be redirected back to the search page in 5 seconds.'
    }));
  },

  displayAlert: function(options) {
    options = options || {};
    var notificationView = new FF.Views.NotificationItem(options);
    options['timeoutId'] = setTimeout(_.bind(notificationView.navigateToSearch, notificationView), 5000);
    FF.mainRegion.show(notificationView);
  }

});
