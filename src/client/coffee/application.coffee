###
Application
###
FB = new Marionette.Application
  
  # architecture namespaces
  Collections: {}
  Models: {}
  Regions: {}
  Views: {}
  
  # Number Helpers
  Number:
    toMoney: (number) ->
      n = number
      c = 2
      d = '.'
      t = ','
      sign = (if (n < 0) then '-' else '')
      i = parseInt(n = Math.abs(n).toFixed(c)) + ''
      j = (if ((j = i.length) > 3) then j % 3 else 0)
      sign + ((if j then i.substr(0, j) + t else '')) + i.substr(j).replace(/(\d{3})(?=\d)/g, '$1' + t) + ((if c then d + Math.abs(n - i).toFixed(c).slice(2) else ''))

    isNumeric: (number) ->
      not isNaN(parseFloat(number)) and isFinite(number)

    fromMoney: (number) ->
      parseFloat number.toString().replace(',', '')

  
  # String Helpers
  String:
    toMoney: (string) ->
      FB.Number.toMoney parseFloat(string)

    fromMoney: (string) ->
      string.replace ',', ''

# setup application
FB.addInitializer ->
  @controller = new @Controller()
  @router = new @Router controller: @controller
  @mainRegion = new @Regions.Main()
  return

# config for Messenger
FB.addInitializer ->
  Messenger.options =
    extraClasses: 'messenger-fixed messenger-on-bottom messenger-on-right'
    theme: 'flat'
  return

# Start Google Analytics
FB.addInitializer ->
  _gaq = _gaq or []
  _gaq.push [
    "_setAccount"
    "UA-39622852-1"
  ]
  _gaq.push ["_trackPageview"]
  ga = document.createElement("script")
  ga.type = "text/javascript"
  ga.async = true
  ga.src = ((if "https:" is document.location.protocol then "https://ssl" else "http://www")) + ".google-analytics.com/ga.js"
  s = document.getElementsByTagName("script")[0]
  s.parentNode.insertBefore ga, s
  return


# start Backbone history
FB.on 'initialize:after', ->
  Backbone.history.start pushState: true