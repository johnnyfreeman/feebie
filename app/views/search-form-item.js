'use strict';

FF.Views.SearchFormItem = Marionette.ItemView.extend({

  template: '#tplSearchForm',

  id: 'search',

  events: {
    'submit form': 'navigateToCode'
  },

  ui: {
    textbox: "input"
  },

  options: {
    focusOnShow: false
  },

  onShow: function() {
    if (this.options.focusOnShow) this.ui.textbox.trigger('focus');
  },

  navigateToCode: function(e) {
    e.preventDefault();
    FF.router.navigate( this.ui.textbox.val(), {trigger: true} );
  }

});