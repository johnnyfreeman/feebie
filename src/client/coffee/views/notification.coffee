window.FF.Views.Notification = Marionette.ItemView.extend

  # wrap view with li.notification
  className: 'notification'
  tagName: 'li'

  # template
  template: '#tplNotification'

  # events
  events:
    'click .notification-dismiss': 'dismissOnClick'
    'mouseover': 'clearTimout'

  modelEvents:
    'destroy': 'clearTimout'

  clearTimout: ->
    clearTimeout @model.timeoutId

  dismissOnClick: (e) ->
    e.preventDefault()
    @model.destroy()