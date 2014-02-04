window.FF.Views.SearchForm = Marionette.ItemView.extend

  # html template
  template: '#tplSearchForm'

  # wrap template with div#search element
  id: 'search'

  # events
  events:
    'submit form': 'navigateToCode'

  # ui elements
  ui:
    textbox: 'input'

  # options passed to constructor
  options:
    focusOnShow: false

  # after this view is made visible in a region
  onShow: ->
    @ui.textbox.trigger 'focus' if @options.focusOnShow

  # on form submit
  navigateToCode: (e) ->
    e.preventDefault()
    window.FF.router.navigate @ui.textbox.val(),
      trigger: true