window.FB.Router = Marionette.AppRouter.extend
  appRoutes:
    '': 'displaySearch'
    ':code': 'displayCode'

  
  # update google analytics
  navigate: (fragment, options) ->
    _gaq.push [
      '_trackPageview'
      fragment
    ]
    Marionette.AppRouter::navigate.call this, fragment, options