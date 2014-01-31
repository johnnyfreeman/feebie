window.FF.Models.Options = Backbone.Model.extend(

  # default options
  defaults:
    fac: []
    coInsuranceMultiplier: .2
    quantity: []
    modifier1: []
    modifier2: []
    year: []

  parseFees: (fees) ->
    options = @
    fees.each (fee) ->
      options.addToOptionCollection 'fac', fee.get('fac')
      options.addToOptionCollection 'quantity', fee.get('quantity')
      options.addToOptionCollection 'modifier1', fee.get('modifier1')
      options.addToOptionCollection 'modifier2', fee.get('modifier2')
      options.addToOptionCollection 'year', fee.get('year')

  addToOptionCollection: (name, value) ->
    collection = @get name
    collection.push value unless _.contains collection, value



)
