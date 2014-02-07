window.FF.Models.Notification = Backbone.Model.extend
  defaults:
    title: ''
    message: ''
    timeout: 5000
    iconClass: 'fa-info-sign'

  timeoutId: null

  initialize: ->
    # destroy self after a few seconds
    to = @get 'timeout'
    @timeoutId = setTimeout(_.bind(@destroy, this), to) if $.isNumeric(to)

  # overriding sync method so it does not
  # try to `save()` this model to the server
  sync: ->
    