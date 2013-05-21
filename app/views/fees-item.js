'use strict';

FF.Views.FeesItem = Marionette.ItemView.extend({

  className: 'fees',

  template : '#tplFeesItem',

  ui: {
    copyBtns: '.copy-to-clipboard'
  },

  initialize: function() {
    this.listenTo(this.model, 'change', _.bind(this.render, this));

    var model = this.model;
    this.listenTo(this.model, 'change:coInsurance', _.bind(function() {
      var message = 'The co-insurance amount has been recalculated at <em>$' + model.get('coInsurance') + '</em>.';
      FF.notificationsRegion.show(new FF.Views.NotificationInfoItem({message: message}));
    }, this));
  },

  onRender: function(e) {
    setTimeout(_.bind(this.zclip, this), 0);
  },

  // zclip
  zclip: function() {
    var $copyBtn = this.ui.copyBtns;

    if ($copyBtn.length) { // && !this.zclipped
      $copyBtn.zclip({
        path: 'assets/jquery-zclip/ZeroClipboard.swf',
        copy: function(){
          return $(this).prev('.amount').text();
        },
        afterCopy:function(){
          var copied = $(this).find('.copied')[0];
          TweenLite.to(copied, 0.2, {
            left: 0,
            onComplete:function() {
              TweenLite.to(copied, 0.2, {
                left:348,
                delay: 2,
                onComplete: function() {
                  $(copied).css('left', -348);
                }
              });
            }
          });
        }
      });
    }
  }
});
