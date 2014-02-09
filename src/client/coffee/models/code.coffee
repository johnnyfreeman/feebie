mricodes = ['74181', '74183', '70551', '70552', '70553', 'A9579', '73718', '73720', '73721', '73723', '70540',
'70543', '72195', '72197', '72141', '72142', '72156', '72146', '72147', '72157', '72148', '72149', '72158',
'70336', '73218', '73220', '73221', '73222', '73223', 'A9577', '70544', '70545', '70546', '70547', '70548',
'70549', '71555', '73725', '74185']

window.FB.Models.Code = Backbone.Model.extend

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
    @filter = new window.FB.Models.Filter [], code: this

    if @get('code') in mricodes
      @fees = new window.FB.Collections.MriFees [], code: this
    else
      @fees = new window.FB.Collections.Fees [], code: this