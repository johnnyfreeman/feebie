window.FF.Regions.Main = Marionette.Region.extend(
  el: '#main'
  # open: (view) ->

  #   # region
  #   $region = @$el
  #   region = @el

  #   # new content
  #   $newContent = view.$el.css 'opacity', 0
  #   newContent = view.el

  #   # replace old content with new
  #   # content and get heighth
  #   $region.html newContent
  #   newRegionHeight = $newContent.outerHeight()

  #   # fade in
  #   TweenLite.to newContent, 1,
  #       opacity: 1

  #   # animate region height
  #   TweenLite.to region, .5,
  #     height: newRegionHeight
)
