'use strict';

FF.Models.Code = Backbone.Model.extend({

  urlRoot : '/api/fee',

  url: function() {
    return this.urlRoot + '/' + encodeURI(this.get('code'));
  },

  defaults: {
    code: '',
    description: '',
    fees: []
  },

  feesCollection: null,

  initialize: function() {
    var code = this;

    this.feesCollection = new FF.Collections.Fees;

    // when the fees array changes, reset the options collection
    this.listenTo(this, 'change:fees', function(code, fees) {
      code.feesCollection.reset(fees);
    });
  },


});