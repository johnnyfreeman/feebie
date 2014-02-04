window.FF.Models.Code = Backbone.Model.extend

  # url to API endpoint
  urlRoot: 'http://localhost:81/code'
  url: ->
    @urlRoot + '/' + encodeURI(@get('code'))

  # Model defaults
  defaults:
    code: ''
    description: ''
    fees: []

  # main collection of fees that
  # represents the whole list of
  # fees that are tied to this code
  fees: null

  # this options model dictates
  # which fees are hidden or not
  filter: null

  # constructor
  initialize: ->
    @filter = new window.FF.Models.Filter code: this
    @fees = new window.FF.Collections.Fees code: this