window.FF.Collections.Fees = Backbone.Collection.extend(
  
  # model
  model: window.FF.Models.Fee

  # filter by model value
  filterBy: (name, value) ->
    filtered = @filter (model) ->
      model.get(name) == value

    # return new filtered collection
    new window.FF.Collections.Fees filtered

  # filter by year
  byYear: (year) ->
    @filterBy 'year', year

  # filter by year
  byFac: (fac) ->
    @filterBy 'fac', fac

)