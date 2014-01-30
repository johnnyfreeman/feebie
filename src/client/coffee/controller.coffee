window.FF.Controller = Marionette.Controller.extend(
  
  # initialize: function() {
  
  # },
  displayHelp: ->
    console.log 'help controller called.'
    return

  displaySearch: (options) ->
    window.FF.mainRegion.show new window.FF.Views.SearchForm(options)
    return

  lookUpCode: (code) ->
    codeModel = new window.FF.Models.Code(code: code.toUpperCase())
    response = codeModel.fetch()
    response.done ->
      window.FF.mainRegion.show new window.FF.Views.Code(model: codeModel)
      return

    response.fail _.bind(@displayAlert, this,
      title: 'Holy Guacamole!'
      description: 'That code cannot be found. You will be redirected back to the search page in 5 seconds.'
    )
    return

  displayAlert: (options) ->
    options = options or {}
    notificationView = new window.FF.Views.Notification(options)
    options['timeoutId'] = setTimeout(_.bind(notificationView.navigateToSearch, notificationView), 5000)
    window.FF.mainRegion.show notificationView
    return
)
