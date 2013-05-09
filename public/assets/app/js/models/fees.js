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
    // allowable
    var allowable = this.get('allowable');
    this.set('allowable', FF.Number.toMoney(allowable));

    // coinsurance
    this.calculateCoInsurance();

    // self pay
    var selfPay = this.get('selfPay') === undefined ? allowable * this.collection.config.selfPayMultiplier : this.get('selfPay');
    this.set('selfPay', FF.Number.toMoney(selfPay));

    // fac
    var fac = this.get('fac');
    this.set('fac', fac ? 'Facility' : 'Non-Facility');

    // modifier1
    if (!this.get('modifier1')) {
      this.set('modifier1', 'none');
    }

    // modifier2
    if (!this.get('modifier2')) {
      this.set('modifier2', 'none');
    }

    this.listenTo(this.collection, 'change:config:coInsuranceMultiplier', _.bind(this.calculateCoInsurance, this));
  },

  calculateCoInsurance: function() {
    var newMultiplier = this.collection.config.coInsuranceMultiplier;
    var newValue = FF.Number.fromMoney(this.get('allowable')) * newMultiplier;
    this.set({
      'coInsuranceMultiplier': parseInt(newMultiplier * 100),
      'coInsurance': FF.Number.toMoney(newValue)
    });
  }

});
