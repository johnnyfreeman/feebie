'use strict';

FF.Models.Fees = Backbone.Model.extend({

  defaults: {
    // allowable: '',
    // coInsurance: '',
    // selfPay: '',
    // fac: false,
    // modifier1: '',
    // modifier2: '',
    // quantity: 1
  },

  initialize: function() {
    // calculate the coInsurance and selfpay right away
    var allowable = this.get('allowable');
    this.set('allowable', FF.Number.toMoney(allowable));
    this.calculateCoInsurance();
    this.set('selfPay', FF.Number.toMoney(allowable * this.collection.config.selfPayMultiplier));

    var fac = this.get('fac');
    this.set('fac', fac ? 'Out of Office' : 'In Office');

    if (!this.get('modifier1')) {
      this.set('modifier1', 'none');
    };

    if (!this.get('modifier2')) {
      this.set('modifier2', 'none');
    };

    this.listenTo(this.collection, 'change:config:coInsuranceMultiplier', _.bind(this.calculateCoInsurance, this));
  },

  calculateCoInsurance: function() {
    var newValue = FF.Number.fromMoney(this.get('allowable')) * this.collection.config.coInsuranceMultiplier;
    this.set('coInsurance', FF.Number.toMoney(newValue));
    this.set('coInsuranceMultiplier', parseInt(this.collection.config.coInsuranceMultiplier * 100));
  }

});