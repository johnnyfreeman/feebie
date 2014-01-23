FF.Views.NotificationInfoItem = FF.Views.NotificationItem.extend(
  className: 'notification notification-info'
  events:
    'click .notification-dismiss': 'dismissOnClick'

  initialize: ->
    @options.iconClass = 'icon-info-sign'
    return
)
