window.FB.Regions.Main = Marionette.Region.extend
  el: '#main'
  open: (view) ->
    # region
    $region = @$el
    region = @el

    # new content
    $newContent = view.$el.css 'opacity', 0
    newContent = view.el

    # replace old content with new content
    $region.html newContent

    # fade in
    TweenLite.to newContent, .3,
        opacity: 1