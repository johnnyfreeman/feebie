FF.Views.Code = Marionette.ItemView.extend(
  id: 'code'
  template: '#tplCode'
  events:
    'click .close-fee': 'closeOnClick'

  modelEvents:
    change: 'render'
    destroy: 'remove'

  $body: $('body')
  initialize: ->
    @closeOnEscape = _.bind((e) ->
      key = e.which or e.keyCode
      if key is 27
        e.preventDefault()
        @navigateToSearch()
      return
    , this)
    @$body.on 'keydown', @closeOnEscape
    
    # hide all popovers when clicking outside
    # of a popover and not clicking on a trigger
    @$body.on 'click', (e) ->
      $target = $(e.target)
      $('.popover-trigger').popover 'hide'  if $target.closest('.popover').length is 0 and $target.hasClass('popover-trigger') is false
      return

    @optionsItemView = new FF.Views.OptionsItem(model: @model.feesCollection.activeFees)
    @feesItemView = new FF.Views.FeesItem(model: @model.feesCollection.activeFees)
    @listenTo @model.feesCollection, 'change:activeFees', _.bind(@renderChildViews, this)
    return

  closeOnEscape: null
  closeOnClick: (e) ->
    e.preventDefault()
    @navigateToSearch()
    return

  
  # after rendering title, description, and config...
  onRender: (codeView) ->
    @$el.append @optionsItemView.render().el
    @$el.append @feesItemView.render().el
    return

  renderChildViews: ->
    newActiveFees = @model.feesCollection.activeFees
    @optionsItemView.model = newActiveFees
    @feesItemView.model = newActiveFees
    @optionsItemView.stopListening()
    @feesItemView.stopListening()
    @optionsItemView.listenTo newActiveFees, 'change', _.bind(@optionsItemView.render, this)
    @feesItemView.listenTo newActiveFees, 'change', _.bind(@feesItemView.render, this)
    @feesItemView.listenTo newActiveFees, 'change:coInsurance', _.bind(@feesItemView.coInsuranceChangeNotification, @feesItemView)
    @feesItemView.listenTo newActiveFees, 'change:fac', _.bind(@feesItemView.locationChangeNotification, @feesItemView)
    @optionsItemView.render()
    @feesItemView.render()
    return

  navigateToSearch: ->
    @$body.off 'keydown', @closeOnEscape
    @model.destroy()
    FF.controller.displaySearch focusOnShow: true
    FF.router.navigate ''
    return
)
