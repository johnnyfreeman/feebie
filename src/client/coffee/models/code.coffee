FF.Models.Code = Backbone.Model.extend(
  urlRoot: '/api/fee'
  url: ->
    @urlRoot + '/' + encodeURI(@get('code'))

  defaults:
    code: ''
    description: ''
    fees: []

  feesCollection: null
  initialize: ->
    code = this
    @feesCollection = new FF.Collections.Fees
    
    # when the fees array changes, reset the options collection
    @listenTo this, 'change:fees', (code, fees) ->
      code.feesCollection.reset fees
      return

    return
)
