window.FB.Controller = Marionette.Controller.extend

  displaySearch: (options) ->
    window.FB.mainRegion.show new window.FB.Views.SearchForm(options)

  displayCode: (code) ->
    controller = this

    # create code model
    code = new window.FB.Models.Code code: code

    # fetch from server
    response = code.fetch()

    # on success
    # create the view and pass model to it
    response.done ->
      window.FB.mainRegion.show new window.FB.Views.Code model: code

    # on failure
    response.fail ->
      # notification
      Messenger().post
        message: code.get('code') + ' could not be found.'
        type: 'error'

      # if current view isn't SearchForm, show that view
      unless window.FB.mainRegion.currentView instanceof window.FB.Views.SearchForm
        controller.displaySearch focusOnShow: true

      # select text inside textbox
      window.FB.mainRegion.currentView.ui.textbox.select()