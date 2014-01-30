window.FF.Views.Code = Marionette.ItemView.extend(
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

    @optionsView = new window.FF.Views.Options
    @feesView = new window.FF.Views.Fees collection: @model.fees
    # @listenTo @model.feesCollection, 'change:activeFees', _.bind(@renderChildViews, this)
    return

  closeOnEscape: null
  closeOnClick: (e) ->
    e.preventDefault()
    @navigateToSearch()
    return

  
  # after rendering title, description, and config...
  onRender: (codeView) ->
    @$el.append @optionsView.render().el
    # @$el.append @feesView.render().el
    # return

  # renderChildViews: ->
  #   newActiveFees = @model.feesCollection.activeFees
  #   @optionsView.model = newActiveFees
  #   @feesView.model = newActiveFees
  #   @optionsView.stopListening()
  #   @feesView.stopListening()
  #   @optionsView.listenTo newActiveFees, 'change', _.bind(@optionsView.render, this)
  #   @feesView.listenTo newActiveFees, 'change', _.bind(@feesView.render, this)
  #   @feesView.listenTo newActiveFees, 'change:coInsurance', _.bind(@feesView.coInsuranceChangeNotification, @feesView)
  #   @feesView.listenTo newActiveFees, 'change:fac', _.bind(@feesView.locationChangeNotification, @feesView)
  #   @optionsView.render()
  #   @feesView.render()
  #   return

  # navigateToSearch: ->
  #   @$body.off 'keydown', @closeOnEscape
  #   @model.destroy()
  #   window.FF.controller.displaySearch focusOnShow: true
  #   window.FF.router.navigate ''
  #   return
)
