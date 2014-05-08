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
  ((i, s, o, g, r, a, m) ->
    i['GoogleAnalyticsObject'] = r
    i[r] = i[r] or ->
      (i[r].q = i[r].q or []).push arguments

    i[r].l = 1 * new Date()

    a = s.createElement(o)
    m = s.getElementsByTagName(o)[0]

    a.async = 1
    a.src = g
    m.parentNode.insertBefore a, m
  ) window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga'
  ga 'create', 'UA-39622852-2', '192.168.37.31'
  ga 'send', 'pageview'