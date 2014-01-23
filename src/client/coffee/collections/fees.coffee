FF.Collections.Fees = Backbone.Collection.extend(
  model: FF.Models.Fees
  config: {}
  activeFees: null
  initialize: ->
    that = this
    @config =
      coInsuranceMultiplier: .2
      selfPayMultiplier: 1.2

    
    # on fees reset, recalculate the fees
    @listenTo this, 'reset', ->
      that.setActiveFees that.at(0), true
      return

    return

  setActiveFees: (model, silence) ->
    silence = false  if typeof silence is 'undefined'
    @activeFees = model
    @trigger 'change:activeFees'  unless silence
    return

  setCoInsurance: (multiplier, silence) ->
    silence = false  if typeof silence is 'undefined'
    @config.coInsuranceMultiplier = multiplier / 100
    @trigger 'change:config:coInsuranceMultiplier'  unless silence
    return
)
