FF.Regions.Main = Marionette.Region.extend(
  el: '#main'
  open: (view) ->
    @$el.html view.el
    region = @$el[0]
    $newChildren = @$el.children()
    newHeight = 0
    $newChildren.each ->
      $this = $(this)
      $this.css 'opacity', 0
      newHeight = newHeight + $this.outerHeight()
      TweenLite.to this, 1,
        opacity: 1

      return

    TweenLite.to region, .5,
      height: newHeight

    return
)
