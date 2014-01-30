window.FF.Views.SearchForm = Marionette.ItemView.extend(
  template: '#tplSearchForm'
  id: 'search'
  events:
    'submit form': 'navigateToCode'

  ui:
    textbox: 'input'

  options:
    focusOnShow: false

  onShow: ->
    @ui.textbox.trigger 'focus'  if @options.focusOnShow
    return

  navigateToCode: (e) ->
    e.preventDefault()
    window.FF.router.navigate @ui.textbox.val(),
      trigger: true

    return
)
