'use strict';

FF.Views.Code = Marionette.ItemView.extend({

  id: 'code',

  template : '#tplCode',

  events: {
    'click .close-fee': 'closeOnClick'
  },

  modelEvents: {
    'change': 'render',
    'destroy': 'remove'
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

    this.optionsItemView = new FF.Views.OptionsItem({model: this.model.feesCollection.activeFees});
    this.feesItemView = new FF.Views.FeesItem({model: this.model.feesCollection.activeFees});

    this.listenTo(this.model.feesCollection, 'change:activeFees', _.bind(this.renderChildViews, this));
  },

  closeOnEscape: null,
  closeOnClick: function(e) {
    e.preventDefault();
    this.navigateToSearch();
  },

  // after rendering title, description, and config...
  onRender: function(codeView) {
    this.$el.append(this.optionsItemView.render().el);
    this.$el.append(this.feesItemView.render().el);
  },

  renderChildViews: function() {
    var newActiveFees = this.model.feesCollection.activeFees;

    this.optionsItemView.model = newActiveFees;
    this.feesItemView.model = newActiveFees;

    this.optionsItemView.stopListening();
    this.feesItemView.stopListening();
    this.optionsItemView.listenTo(newActiveFees, 'change', _.bind(this.optionsItemView.render, this));
    this.feesItemView.listenTo(newActiveFees, 'change', _.bind(this.feesItemView.render, this));

    this.optionsItemView.render();
    this.feesItemView.render();
  },

  navigateToSearch: function() {
    this.$body.off('keydown', this.closeOnEscape);
    this.model.destroy();
    FF.controller.displaySearch({focusOnShow: true});
    FF.router.navigate('');
  }
});