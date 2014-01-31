window.FF.Models.Code = Backbone.Model.extend(

  # url to API endpoint
  urlRoot: 'http://localhost:81/code'
  url: ->
    @urlRoot + '/' + encodeURI(@get('code'))

  # Model defaults
  defaults:
    code: ''
    description: ''
    fees: []

  # constructor
  initialize: ->

    # TODO: maybe create missing Fee Model objects here for
    # undeclared coinsurance and selfpay

    

    @on 'sync', (model, obj) ->
      # transform fees array to an actual Collection,
      # prevent triggering "change" event since
      # nothing is actually being changed
      fees = new window.FF.Collections.Fees obj.fees

      # save
      model.set 'fees', fees, {silent: true}
)
