window.FF.Views.Filter = Marionette.ItemView.extend
  className: 'row'

  # transform certain model properties
  # to something more human friendly
  template: (model) ->
    data = {}
    data.fac = (if model.fac then 'Out of Office' else 'In Office')
    data.coinsuranceMultiplier = parseInt(model.coinsuranceMultiplier * 100)
    data.modifier1 = (if model.modifier1 == '' then '(none)' else model.modifier1)
    data.modifier2 = (if model.modifier2 == '' then '(none)' else model.modifier2)
    _.template $('#tplOptions').html(), _.extend model, data

  # ui elements
  ui:
    qty: '.quantity-option'
    fac: '.fac-option'
    coInsurance: '.coinsurance-option'
    mod1: '.modifier1-option'
    mod2: '.modifier2-option'
    popoverTriggers: '.popover-trigger'

  modelEvents:
    change: 'render'

  initialize: ->

    _this = this
    
    @$el.on 'click', (e) ->
      e.preventDefault() # all

      target = e.target
      $target = $(target)
      
      # handles hiding and showing of all popovers
      if $target.hasClass('popover-trigger')
        _this.ui.popoverTriggers.not(target).popover 'hide'
        $target.popover 'toggle'
        $target.closest('.option').find('input').trigger 'focus'
      
      # update coinsurance button
      if $target.closest('.btn').length > 0
        # update model
        _this.model.set 'coinsuranceMultiplier', parseInt($target.closest('.btn').siblings('input').val())/100
        # hides popover
        $target.closest('.popover').siblings('.popover-trigger').popover 'hide'
      
      # handles finding the new modal and firing
      # change events so that all appropriate
      # views are re-rendered
      if $target.hasClass('changeModel')
        value = $target.text()
        field = $target.data 'model-field'
        value = parseInt value if field is 'quantity'
        value = '' if value is '(none)'
        _this.model.set field, value

    @$el.on 'keydown', (e) ->
      target = e.target
      $target = $(target)
      if $target.closest('.coinsurance-option .popover')
        if e.which is 13
          e.preventDefault()
          _this.model.set 'coinsuranceMultiplier', parseInt($target.val())/100


  onRender: ->
    _this = this

    # toggle fac value of model when clicked
    @ui.fac.find('a').on 'click', (e) ->
      e.preventDefault()
      _this.model.toggleFac()

    # @buildPopover @ui.fac.find('a'), 'fac'
    @buildCoInsurancePopover()
    @buildPopover @ui.qty.find('a'), 'quantity'
    @buildPopover @ui.mod1.find('a'), 'modifier1'
    @buildPopover @ui.mod2.find('a'), 'modifier2'
    # return

  
  # build popover of unique values in the collection
  buildPopover: (domField, modelField) ->
    currentSelection = @model.get(modelField)
    html = '<ul>'
    uniqueValues = []
    
    # loop through collection
    @model.code.fees.each (model) ->
      value = model.get(modelField)
      unless _.contains(uniqueValues, value)
        uniqueValues.push value
        value = '(none)' if value is ''
        if value is currentSelection
          html += '<li><span>' + value + '</span></li>'
        else
          html += '<li><a class=\'changeModel\' data-model-field=\'' + modelField + '\' href=\'#\'>' + value + '</a></li>'
        

    html += '</ul>'
    
    if uniqueValues.length < 2
      domField.replaceWith '<span class=\'faded\'>' + currentSelection + '</span>'
    else
      domField.popover
        placement: 'bottom'
        trigger: 'manual'
        html: true
        content: html
        container: domField.closest('.option')

  # return

  buildCoInsurancePopover: ->
    coinsuranceMultiplier = parseInt(@model.get('coinsuranceMultiplier')*100)
    @ui.coInsurance.find(@ui.popoverTriggers).popover
      placement: 'bottom'
      trigger: 'manual'
      html: true
      content: '<input placeholder=\'' + coinsuranceMultiplier + '\' type=\'text\'><button class=\'btn btn-success\'><i class=\'fa fa-ok\'></i></button>'
      container: @ui.coInsuranceOption

  # return