window.FF.Router = Marionette.AppRouter.extend(
  appRoutes:
    '': 'displaySearch'
    help: 'displayHelp'
    ':code': 'lookUpCode'

  
  # update google analytics
  navigate: (fragment, options) ->
    _gaq.push [
      '_trackPageview'
      fragment
    ]
    Marionette.AppRouter::navigate.call this, fragment, options
)
