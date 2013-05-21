'use strict';

FF.Views.NotificationItem = Marionette.ItemView.extend({

  className: 'notification',

  tagName: 'li',

  template : function(options) {
    return _.template($('#tplNotificationItem').html(), options);
  },
  // template: '#tplNotificationItem',

  events: {
    'click .notification-dismiss': 'dismissOnClick'
  },

  initialize: function() {

  },

  render: function() {
    this.$el.html(this.template(this.options));
  },

  dismissOnClick: function(e) {
    e.preventDefault();
    this.remove();
  }

});
