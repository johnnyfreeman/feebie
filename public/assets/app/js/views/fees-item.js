'use strict';

FF.Views.FeesItem = Marionette.ItemView.extend({

  className: 'fees',

  template : '#tplFeesItem',

  ui: {
    copyBtns: '.copy-to-clipboard'
  },

  initialize: function() {
    // this.zclipped = false;

    this.listenTo(this.model, 'change', _.bind(this.render, this));
  },

  onRender: function(e) {
    setTimeout(_.bind(this.zclip, this), 0);
    // this.zclip();
  },

  // zclip
  zclip: function() {
    var $copyBtn = this.ui.copyBtns;

    if ($copyBtn.length) { // && !this.zclipped
      $copyBtn.zclip({
        path: 'assets/zclip/ZeroClipboard.swf',
        copy: function(){
          return $(this).prev('.amount').text();
        },
        afterCopy:function(){
          var copied = $(this).find('.copied')[0];
          TweenLite.to(copied, 0.2, {
            left: 0, 
            onComplete:function() {
              TweenLite.to(copied, 0.2, {
                left:273, 
                delay: 2,
                onComplete: function() {
                  $(copied).css('left', -273);
                }
              });
            }
          });
        }
      });
      // this.zclipped = true;
    };
  }
});