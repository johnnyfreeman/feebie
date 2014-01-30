/*
Fee Finder Application
*/

window.FF = new Marionette.Application({
  Collections: {},
  Models: {},
  Regions: {},
  Views: {},
  Number: {
    toMoney: function(number) {
      var c, d, i, j, n, sign, t;
      n = number;
      c = 2;
      d = '.';
      t = ',';
      sign = (n < 0 ? '-' : '');
      i = parseInt(n = Math.abs(n).toFixed(c)) + '';
      j = ((j = i.length) > 3 ? j % 3 : 0);
      return sign + (j ? i.substr(0, j) + t : '') + i.substr(j).replace(/(\d{3})(?=\d)/g, '$1' + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : '');
    },
    isNumeric: function(number) {
      return !isNaN(parseFloat(number)) && isFinite(number);
    },
    fromMoney: function(number) {
      return parseFloat(number.toString().replace(',', ''));
    }
  },
  String: {
    toMoney: function(string) {
      return window.FF.Number.toMoney(parseFloat(string));
    },
    fromMoney: function(string) {
      return string.replace(',', '');
    }
  }
});

window.FF.Models.Code = Backbone.Model.extend({
  urlRoot: 'http://localhost:81/code',
  url: function() {
    return this.urlRoot + '/' + encodeURI(this.get('code'));
  },
  defaults: {
    code: '',
    description: '',
    fees: []
  },
  initialize: function() {
    return this.on('sync', function(model, obj) {
      var fees;
      fees = new window.FF.Collections.Fees(obj.fees);
      fees = fees.byYear('2014');
      return model.set('fees', fees, {
        silent: true
      });
    });
  }
});

window.FF.Models.Fee = Backbone.Model.extend({
  defaults: {},
  initialize: function() {}
});

window.FF.Models.Notification = Backbone.Model.extend({
  defaults: {},
  initialize: function() {}
});

window.FF.Collections.Fees = Backbone.Collection.extend({
  model: window.FF.Models.Fee,
  filterBy: function(name, value) {
    var filtered;
    filtered = this.filter(function(model) {
      return model.get(name) === value;
    });
    return new window.FF.Collections.Fees(filtered);
  },
  byYear: function(year) {
    return this.filterBy('year', year);
  },
  byFac: function(fac) {
    return this.filterBy('fac', fac);
  }
});

window.FF.Collections.Notifications = Backbone.Collection.extend({
  model: window.FF.Models.Notification
});

window.FF.Regions.Main = Marionette.Region.extend({
  el: '#main',
  open: function(view) {
    var $newChildren, newHeight, region;
    this.$el.html(view.el);
    region = this.$el[0];
    $newChildren = this.$el.children();
    newHeight = 0;
    $newChildren.each(function() {
      var $this;
      $this = $(this);
      $this.css('opacity', 0);
      newHeight = newHeight + $this.outerHeight();
      TweenLite.to(this, 1, {
        opacity: 1
      });
    });
    TweenLite.to(region, .5, {
      height: newHeight
    });
  }
});

window.FF.Regions.Notifications = Marionette.Region.extend({
  el: '#notifications'
});

window.FF.Views.Code = Marionette.ItemView.extend({
  id: 'code',
  template: '#tplCode',
  events: {
    'click .close-fee': 'closeOnClick'
  },
  modelEvents: {
    change: 'render',
    destroy: 'remove'
  },
  $body: $('body'),
  initialize: function() {
    this.closeOnEscape = _.bind(function(e) {
      var key;
      key = e.which || e.keyCode;
      if (key === 27) {
        e.preventDefault();
        this.navigateToSearch();
      }
    }, this);
    this.$body.on('keydown', this.closeOnEscape);
    this.$body.on('click', function(e) {
      var $target;
      $target = $(e.target);
      if ($target.closest('.popover').length === 0 && $target.hasClass('popover-trigger') === false) {
        $('.popover-trigger').popover('hide');
      }
    });
    this.optionsView = new window.FF.Views.Options;
    this.feesView = new window.FF.Views.Fees({
      collection: this.model.fees
    });
  },
  closeOnEscape: null,
  closeOnClick: function(e) {
    e.preventDefault();
    this.navigateToSearch();
  },
  onRender: function(codeView) {
    return this.$el.append(this.optionsView.render().el);
  }
});

window.FF.Views.Options = Marionette.ItemView.extend({
  className: 'options',
  template: function(model) {
    var data;
    data = _.extend(model, {});
    return _.template($('#tplOptions').html(), data);
  },
  ui: {
    qtyOption: '.quantity-option',
    facOption: '.fac-option',
    coInsuranceOption: '.coinsurance-option',
    mod1Option: '.modifier1-option',
    mod2Option: '.modifier2-option',
    popoverTriggers: '.popover-trigger'
  },
  initialize: function() {
    var that;
    return that = this;
  },
  onRender: function() {
    this.buildPopover(this.ui.facOption.find('a'), 'fac');
    this.buildCoInsurancePopover();
    this.buildPopover(this.ui.qtyOption.find('a'), 'quantity');
    this.buildPopover(this.ui.mod1Option.find('a'), 'modifier1');
    this.buildPopover(this.ui.mod2Option.find('a'), 'modifier2');
  },
  buildPopover: function(domField, modelField) {},
  buildCoInsurancePopover: function() {}
});

window.FF.Views.Fee = Marionette.ItemView.extend({
  className: 'fee',
  template: '#tplFee'
});

window.FF.Views.Fees = Marionette.CollectionView.extend({
  itemView: window.FF.Views.Fee
});

window.FF.Views.Notification = Marionette.ItemView.extend({
  className: 'notification',
  tagName: 'li',
  template: function(options) {
    return _.template($('#tplNotification').html(), options);
  },
  events: {
    'click .notification-dismiss': 'dismissOnClick'
  },
  initialize: function() {},
  render: function() {
    var that;
    that = this;
    that.$el.html(this.template(this.options));
    setTimeout((function() {
      that.$el.fadeOut(400, _.bind(that.remove, that));
    }), 2500);
  },
  dismissOnClick: function(e) {
    e.preventDefault();
    this.remove();
  }
});

window.FF.Views.NotificationInfo = window.FF.Views.Notification.extend({
  className: 'notification notification-info',
  events: {
    'click .notification-dismiss': 'dismissOnClick'
  },
  initialize: function() {
    this.options.iconClass = 'icon-info-sign';
  }
});

window.FF.Views.SearchForm = Marionette.ItemView.extend({
  template: '#tplSearchForm',
  id: 'search',
  events: {
    'submit form': 'navigateToCode'
  },
  ui: {
    textbox: 'input'
  },
  options: {
    focusOnShow: false
  },
  onShow: function() {
    if (this.options.focusOnShow) {
      this.ui.textbox.trigger('focus');
    }
  },
  navigateToCode: function(e) {
    e.preventDefault();
    window.FF.router.navigate(this.ui.textbox.val(), {
      trigger: true
    });
  }
});

window.FF.Controller = Marionette.Controller.extend({
  displayHelp: function() {
    console.log('help controller called.');
  },
  displaySearch: function(options) {
    window.FF.mainRegion.show(new window.FF.Views.SearchForm(options));
  },
  lookUpCode: function(code) {
    var codeModel, response;
    codeModel = new window.FF.Models.Code({
      code: code.toUpperCase()
    });
    response = codeModel.fetch();
    response.done(function() {
      window.FF.mainRegion.show(new window.FF.Views.Code({
        model: codeModel
      }));
    });
    response.fail(_.bind(this.displayAlert, this, {
      title: 'Holy Guacamole!',
      description: 'That code cannot be found. You will be redirected back to the search page in 5 seconds.'
    }));
  },
  displayAlert: function(options) {
    var notificationView;
    options = options || {};
    notificationView = new window.FF.Views.Notification(options);
    options['timeoutId'] = setTimeout(_.bind(notificationView.navigateToSearch, notificationView), 5000);
    window.FF.mainRegion.show(notificationView);
  }
});

window.FF.Router = Marionette.AppRouter.extend({
  appRoutes: {
    '': 'displaySearch',
    help: 'displayHelp',
    ':code': 'lookUpCode'
  },
  navigate: function(fragment, options) {
    _gaq.push(['_trackPageview', fragment]);
    return Marionette.AppRouter.prototype.navigate.call(this, fragment, options);
  }
});
