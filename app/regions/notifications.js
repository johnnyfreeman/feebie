'use strict';

FF.Regions.Notifications = Marionette.Region.extend({

  el: '#notifications'

  // open: function(view) {
  //   this.$el.html(view.el);

  //   var region        = this.$el[0];
  //   var $newChildren  = this.$el.children();

  //   var newHeight = 0;

  //   $newChildren.each(function(){
  //     var $this = $(this);
  //     $this.css('opacity', 0);
  //     newHeight = newHeight + $this.outerHeight();
  //     TweenLite.to(this, 1, {opacity:1});
  //   });

  //   TweenLite.to(region, .5, {height:newHeight});
  // }
});
