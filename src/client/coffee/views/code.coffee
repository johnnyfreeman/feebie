window.FF.Views.Code = Marionette.ItemView.extend

  # html template
  template: '#tplCode'

  # wrap template with div#code
  id: 'code'

  # events
  events:
    'click .close-fee': 'navigateToSearch'

  # model events mapped to view methods
  modelEvents:
    change: 'render'
    destroy: 'remove'

  # shortcut to body selector
  $body: $ 'body'

  initialize: ->
      
    # navigate back to search form on escape
    @$body.on 'keydown', _.bind @navigateToSearch, this
    
    # hide all popovers when clicking outside
    # of a popover and not clicking on a trigger
    # @$body.on 'click', @closeAllPopups

    # filter
    @filterView = new window.FF.Views.Filter model: @model.filter

    # build fees collection view
    @feesView = new window.FF.Views.Fees collection: @model.fees
  
  # after rendering
  onRender: (codeView) ->
    @$el.append @filterView.render().el
    @$el.append @feesView.render().el

  ###
  Event handlers
  ###

  closeAllPopups: (e) ->
    $target = $ e.target
    $('.popover-trigger').popover 'hide'  if $target.closest('.popover').length is 0 and $target.hasClass('popover-trigger') is false

  # navigate back to search form
  navigateToSearch: (e) ->
    # capture keystrokes except escape
    if e.type == 'keydown'
      key = e.which or e.keyCode
      return if key isnt 27

    # prevent default action
    e.preventDefault()

    # remove handlers from body
    @$body.off 'keydown', @navigateToSearch
    @$body.off 'click', @closeAllPopups

    # destroy model (which in turns
    # triggers this view's destruction)
    @model.destroy()

    # explicitly using controller so that
    # we can pass focusOnShow option
    window.FF.controller.displaySearch focusOnShow: true
    window.FF.router.navigate ''