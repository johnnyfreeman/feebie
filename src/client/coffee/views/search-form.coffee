window.FB.Views.SearchForm = Marionette.ItemView.extend

  # html template
  template: '#tplSearchForm'

  # wrap template with div#search element
  id: 'search'

  # events
  events:
    'submit form': 'displayCode'
    'click .fa-search': 'displayCode'

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
  displayCode: (e) ->
    e.preventDefault()
    window.FB.router.navigate @ui.textbox.val(),
      trigger: true