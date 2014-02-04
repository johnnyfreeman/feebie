window.FF.Views.Notification = Marionette.ItemView.extend
  className: 'notification'
  tagName: 'li'
  template: (options) ->
    _.template $('#tplNotification').html(), options

  
  # template: '#tplNotification',
  events:
    'click .notification-dismiss': 'dismissOnClick'

  initialize: ->

  render: ->
    that = this
    that.$el.html @template(@options)
    
    # fadeout after 2.5 seconds
    setTimeout (->
      that.$el.fadeOut 400, _.bind(that.remove, that)
      return
    ), 2500
    return

  dismissOnClick: (e) ->
    e.preventDefault()
    @remove()
    return