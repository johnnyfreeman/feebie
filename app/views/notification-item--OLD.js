'use strict';

FF.Views.NotificationItem = Marionette.ItemView.extend({

  className: 'alert alert-block alert-error',

  template: _.template('<button type="button" class="close" data-dismiss="alert">&times;</button><strong><%= title %></strong> <%= description %>'),

  events: {
    'click .close': 'closeOnClick'
  },

  $body: $('body'),

  initialize: function() {

    this.closeOnEscape = _.bind(function(e) {
      var key = e.which || e.keyCode;
      if (key === 27) {
        e.preventDefault();
        this.navigateToSearch();
      }
    }, this);

    this.$body.on('keydown', this.closeOnEscape);
  },

  render: function() {
    this.$el.html(this.template(this.options));
  },

  navigateToSearch: function() {
    this.$body.off('keydown', this.closeOnEscape);
    clearTimeout(this.options.timeoutId);
    this.remove();
    FF.controller.displaySearch({focusOnShow: true});
    FF.router.navigate('');
  },

  closeOnEscape: null,
  closeOnClick: function(e) {
    e.preventDefault();
    this.navigateToSearch();
  }

});
