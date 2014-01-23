FF.Views.OptionsItem = Marionette.ItemView.extend(
  className: 'options'
  template: (model) ->
    data = _.extend(model, {})
    _.template $('#tplOptionsItem').html(), data

  ui:
    qtyOption: '.quantity-option'
    facOption: '.fac-option'
    coInsuranceOption: '.coinsurance-option'
    mod1Option: '.modifier1-option'
    mod2Option: '.modifier2-option'
    popoverTriggers: '.popover-trigger'

  initialize: ->
    that = this
    _.bindAll this
    @listenTo @model, 'change', _.bind(@render, this)
    @$el.on 'click', (e) ->
      e.preventDefault() # all
      target = e.target
      $target = $(target)
      
      # handles hiding and showing of all popovers
      if $target.hasClass('popover-trigger')
        that.ui.popoverTriggers.not(target).popover 'hide'
        $target.popover 'toggle'
        $target.closest('.option').find('input').trigger 'focus'
      
      # update coinsurance button
      if $target.closest('.btn').length > 0
        
        # update model
        that.model.collection.setCoInsurance $target.closest('.btn').siblings('input').val()
        
        # hides popover
        $target.closest('.popover').siblings('.popover-trigger').popover 'hide'
      
      # handles finding the new modal and firing
      # change events so that all appropriate
      # views are re-rendered
      if $target.hasClass('changeModel')
        newValue = $target.text()
        modelField = $target.data('model-field')
        changedData = {}
        newValue = parseFloat(newValue)  if modelField is 'quantity'
        changedData[modelField] = newValue
        searchData = _.extend(
          fac: that.model.get('fac')
          quantity: that.model.get('quantity')
          modifier1: that.model.get('modifier1')
          modifier2: that.model.get('modifier2')
        , changedData)
        
        # that.model.set(modelField, newValue);
        results = that.model.collection.where(searchData)
        
        # console.log('found ', results.length, ' model in', that.model.collection, ' where ', searchData);
        
        # triggers change event
        that.model.collection.setActiveFees _.first(results)
      return

    @$el.on 'keydown', (e) ->
      target = e.target
      $target = $(target)
      if $target.closest('.coinsurance-option .popover')
        if e.which is 13
          e.preventDefault()
          that.model.collection.setCoInsurance $target.val()
      return

    return

  onRender: ->
    @buildPopover @ui.facOption.find('a'), 'fac'
    @buildCoInsurancePopover()
    @buildPopover @ui.qtyOption.find('a'), 'quantity'
    @buildPopover @ui.mod1Option.find('a'), 'modifier1'
    @buildPopover @ui.mod2Option.find('a'), 'modifier2'
    return

  
  # build popover of unique values in the collection
  buildPopover: (domField, modelField) ->
    currentSelection = @model.get(modelField)
    html = '<ul>'
    uniqueValues = []
    
    # loop through collection
    @model.collection.each (model) ->
      value = model.get(modelField)
      unless _.contains(uniqueValues, value)
        if value is currentSelection
          html += '<li><span>' + value + '</span></li>'
        else
          html += '<li><a class=\'changeModel\' data-model-field=\'' + modelField + '\' href=\'#\'>' + value + '</a></li>'
        uniqueValues.push value
      return

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

    return

  buildCoInsurancePopover: ->
    @ui.coInsuranceOption.find(@ui.popoverTriggers).popover
      placement: 'bottom'
      trigger: 'manual'
      html: true
      content: '<input placeholder=\'' + @model.get('coInsuranceMultiplier') + '\' type=\'text\'><button class=\'btn btn-success\'><i class=\'icon-ok\'></i></button>'
      container: @ui.coInsuranceOption

    return
)
