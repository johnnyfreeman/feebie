FB.Controller = Marionette.Controller.extend

  displaySearch: (options) ->
    FB.mainRegion.show new FB.Views.SearchForm(options)

  displayCode: (code) ->
    controller = this

    # create code model
    code = new FB.Models.Code code: code

    # fetch from server
    response = code.fetch()

    # on success
    # create the view and pass model to it
    response.done ->
      FB.mainRegion.show new FB.Views.Code model: code

    # on failure
    response.fail ->
      # notification
      Messenger().post
        message: code.get('code') + ' could not be found.'
        type: 'error'

      # if current view isn't SearchForm, show that view
      unless FB.mainRegion.currentView instanceof FB.Views.SearchForm
        controller.displaySearch focusOnShow: true

      # select text inside textbox
      FB.mainRegion.currentView.ui.textbox.select()