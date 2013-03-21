'use strict';

FF.Collections.Fees = Backbone.Collection.extend({

  model: FF.Models.Fees,

  config: {},

  activeFees: null,

  initialize: function() {
  	var that = this;

  	this.config = {
	    coInsuranceMultiplier: .2,
	    selfPayMultiplier: 1.2
  	};

    // on fees reset, recalculate the fees
    this.listenTo(this, 'reset', function() {
      that.setActiveFees(that.at(0), true);
    });
  },

  setActiveFees: function(model, silence) {
  	if (typeof silence === undefined) silence = false;
  	this.activeFees = model;
  	if (!silence) this.trigger('change:activeFees');
  },

  setCoInsurance: function(multiplier, silence) {
  	if (typeof silence === undefined) silence = false;
  	this.config.coInsuranceMultiplier = multiplier / 100;
  	if (!silence) this.trigger('change:config:coInsuranceMultiplier');
  }

});