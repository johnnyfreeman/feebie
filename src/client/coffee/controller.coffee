window.FF.Controller = Marionette.Controller.extend

  displaySearch: (options) ->
    window.FF.mainRegion.show new window.FF.Views.SearchForm(options)

  lookUpCode: (code) ->
    controller = this
    # create code model
    codeModel = new window.FF.Models.Code code: code.toUpperCase()
    # fetch from server
    response = codeModel.fetch()
    # on success
    response.done ->
      window.FF.mainRegion.show new window.FF.Views.Code(model: codeModel)
    # on failure
    response.fail ->
      # notification
      Messenger().post 'That code could not be found.'
      controller.displaySearch focusOnShow: true