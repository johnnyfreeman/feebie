###
Fee Finder Application
###
window.FB = new Marionette.Application
  
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
      window.FB.Number.toMoney parseFloat(string)

    fromMoney: (string) ->
      string.replace ',', ''