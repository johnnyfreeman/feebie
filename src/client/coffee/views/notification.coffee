window.FF.Views.Notification = Marionette.ItemView.extend

  # wrap view with li.notification
  className: 'notification'
  tagName: 'li'

  # template
  template: '#tplNotification'

  # events
  events:
    'click .notification-dismiss': 'dismissOnClick'

  dismissOnClick: (e) ->
    e.preventDefault()
    clearTimeout @model.timeoutId
    @model.destroy()