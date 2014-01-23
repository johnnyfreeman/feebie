FF.Controller = Marionette.Controller.extend(
  
  # initialize: function() {
  
  # },
  displayHelp: ->
    console.log 'help controller called.'
    return

  displaySearch: (options) ->
    FF.mainRegion.show new FF.Views.SearchFormItem(options)
    return

  lookUpCode: (code) ->
    codeModel = new FF.Models.Code(code: code.toUpperCase())
    response = codeModel.fetch()
    response.done ->
      FF.mainRegion.show new FF.Views.Code(model: codeModel)
      return

    response.fail _.bind(@displayAlert, this,
      title: 'Holy Guacamole!'
      description: 'That code cannot be found. You will be redirected back to the search page in 5 seconds.'
    )
    return

  displayAlert: (options) ->
    options = options or {}
    notificationView = new FF.Views.NotificationItem(options)
    options['timeoutId'] = setTimeout(_.bind(notificationView.navigateToSearch, notificationView), 5000)
    FF.mainRegion.show notificationView
    return
)
