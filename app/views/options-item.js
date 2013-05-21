'use strict';

FF.Views.OptionsItem = Marionette.ItemView.extend({

  className: 'options',

  template : function(model) {

    var data = _.extend(model, {
    });

    return _.template($('#tplOptionsItem').html(), data);
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
    var that = this;
    _.bindAll(this);

    this.listenTo(this.model, 'change', _.bind(this.render, this));

    this.$el.on('click', function(e) {
      e.preventDefault(); // all

      var target = e.target;
      var $target = $(target);

      // handles hiding and showing of all popovers
      if ($target.hasClass('popover-trigger')) {
        that.ui.popoverTriggers.not(target).popover('hide');
        $target.popover('toggle');
        $target.closest('.option').find('input').trigger('focus');
      }

      // update coinsurance button
      if ($target.closest('.btn').length > 0) {
        // update model
        that.model.collection.setCoInsurance($target.closest('.btn').siblings('input').val());
        // hides popover
        $target.closest('.popover').siblings('.popover-trigger').popover('hide');
      }

      // handles finding the new modal and firing
      // change events so that all appropriate
      // views are re-rendered
      if ($target.hasClass('changeModel')) {
        var newValue = $target.text();
        var modelField = $target.data('model-field');
        var changedData = {};

        if (modelField === 'quantity') {
          newValue = parseFloat(newValue);
        }

        changedData[modelField] = newValue;
        var searchData = _.extend({
          fac: that.model.get('fac'),
          quantity: that.model.get('quantity'),
          modifier1: that.model.get('modifier1'),
          modifier2: that.model.get('modifier2')
        }, changedData);

        // that.model.set(modelField, newValue);
        var results = that.model.collection.where(searchData);
        // console.log('found ', results.length, ' model in', that.model.collection, ' where ', searchData);

        // triggers change event
        that.model.collection.setActiveFees(_.first(results));
      }
    });

    this.$el.on('keydown', function(e) {
      var target = e.target;
      var $target = $(target);

      if ($target.closest('.coinsurance-option .popover')) {
        if (e.which === 13) {
          e.preventDefault();
          that.model.collection.setCoInsurance($target.val());
        }
      }
    });
  },

  onRender: function() {
    this.buildPopover(this.ui.facOption.find('a'), 'fac');
    this.buildCoInsurancePopover();
    this.buildPopover(this.ui.qtyOption.find('a'), 'quantity');
    this.buildPopover(this.ui.mod1Option.find('a'), 'modifier1');
    this.buildPopover(this.ui.mod2Option.find('a'), 'modifier2');
  },

  // build popover of unique values in the collection
  buildPopover: function(domField, modelField) {
    var currentSelection = this.model.get(modelField);
    var html = '<ul>';
    var uniqueValues = [];
    // loop through collection
    this.model.collection.each(function(model) {
      var value = model.get(modelField);

      if (!_.contains(uniqueValues, value)) {
        if (value === currentSelection) {
          html += '<li><span>' + value + '</span></li>';
        } else {
          html += '<li><a class="changeModel" data-model-field="' + modelField + '" href="#">' + value + '</a></li>';
        }
        uniqueValues.push(value);
      }
    });
    html += '</ul>';
    if (uniqueValues.length < 2) {
      domField.replaceWith('<span class="faded">' + currentSelection + '</span>');
    } else {
      domField.popover({
        placement: 'bottom',
        trigger: 'manual',
        html: true,
        content: html,
        container: domField.closest('.option')
      });
    }
  },

  buildCoInsurancePopover: function() {
    this.ui.coInsuranceOption.find(this.ui.popoverTriggers).popover({
        placement: 'bottom',
        trigger: 'manual',
        html: true,
        content: '<input placeholder="' + this.model.get('coInsuranceMultiplier') + '" type="text"><button class="btn btn-success"><i class="icon-ok"></i></button>',
        container: this.ui.coInsuranceOption
      });
  }
});
