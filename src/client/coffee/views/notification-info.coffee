window.FF.Views.NotificationInfo = window.FF.Views.Notification.extend
  className: 'notification notification-info'
  events:
    'click .notification-dismiss': 'dismissOnClick'

  initialize: ->
    @options.iconClass = 'icon-info-sign'
    return