'use strict';

/**
 * Fee Finder Application
 */
var FF = new Marionette.Application({

  // architecture namespaces
  Collections: {},
  Models:      {},
  Regions:     {},
  Views:       {},

  // Number Helpers
  Number: {
    toMoney: function(number) {
      var n = number, c = 2, d = '.', t = ',', 
      sign = (n < 0) ? '-' : '',
      i = parseInt(n = Math.abs(n).toFixed(c)) + '', 
      j = ((j = i.length) > 3) ? j % 3 : 0; 
      return sign + (j ? i.substr(0, j) + t : '') + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : ''); 
    },
    isNumeric: function(number) {
      return !isNaN(parseFloat(number)) && isFinite(number);
    },
    fromMoney: function(number) {
      return parseFloat(number.toString().replace(',', ''));
    }
  },

  // String Helpers
  String: {
    toMoney: function(string) {
      return FF.Number.toMoney(parseFloat(string));
    },
    fromMoney: function(string) {
      return string.replace(',', '');
    }
  }
});