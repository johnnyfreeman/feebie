window.FB.Controller = Marionette.Controller.extend

  displaySearch: (options) ->
    window.FB.mainRegion.show new window.FB.Views.SearchForm(options)

  lookUpCode: (code) ->
    controller = this
    # create code model
    codeModel = new window.FB.Models.Code code: code.toUpperCase()
    # fetch from server
    response = codeModel.fetch()
    # on success
    response.done ->
      window.FB.mainRegion.show new window.FB.Views.Code(model: codeModel)
    # on failure
    response.fail ->
      # notification
      Messenger().post 
        message: 'That code could not be found.'
        type: "error"
      controller.displaySearch focusOnShow: true