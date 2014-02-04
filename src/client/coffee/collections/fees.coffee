window.FF.Collections.Fees = Backbone.Collection.extend
  
  # model
  model: window.FF.Models.Fee

  # fees are always passed
  # to the initialize method
  initialize: (options) ->
    _this = this

    # save reference to the code
    # this collection belongs to
    @code = options.code

    # when the code is synced to the
    # server, update this fees collection
    @code.on 'sync', (code) ->
      _this.reset code.get 'fees'

    # create coinsurance/selfpay fees
    @on 'reset', (fees) ->
      # new fees array
      newFees = []
      # loop through fees
      fees.each (fee) ->
        # insert coinsurance for each
        newFees.push fee.cloneAsCoinsurance()
        # insert selfpay for each (if not already there)
        newFees.push fee.cloneAsSelfPay()
      # add new fees to the collection
      fees.add newFees

      # get filter attrs from first fee in the collection
      # then we'll save that as the current filter
    @on 'reset', (fees) ->
      _this.code.filter.set fees.at(0).getFilterAttrs()

    # show/hide fees when fees are reset based
    # on current filter and also each time the filter changes
    @on 'reset', _.bind(@autoShowHideAll, this)
    @listenTo @code.filter, 'change', _.bind(@autoShowHideAll, this)

    # recalculate all coinsurance fees when the
    # filter's coinsurance multiplier changes
    @listenTo @code.filter, 'change:coinsuranceMultiplier', (model) ->
      _.each _this.where(categoryId:'COINSURANCE'), (fee) ->
        fee.set 'amount', (fee.source.get('amount')*model.changed.coinsuranceMultiplier).toFixed(2)

  autoShowHideAll: () ->
    # hide all
    @hideAll()
    # get filter attrs
    filterAttrs = @code.filter.getFilterAttrs()
    # show fees that match
    # the current filter state
    _.invoke @where(filterAttrs), 'show'

  showAll: () ->
    @each (fee) ->
      fee.show()

  hideAll: () ->
    @each (fee) ->
      fee.hide()

  # -1 = 1 before 2
  #  0 = same
  #  1 = 1 after 2
  comparator: (fee1, fee2) ->
    
    f1 = fee1.toJSON()
    f2 = fee2.toJSON()

    # fac
    if f1.fac != f2.fac
      # console.log 'by_fac', (if f1.fac == true then -1 else 1), f1.fac, f2.fac
      return (if f1.fac == false then -1 else 1)

    # quantity
    if f1.quantity != f2.quantity
      # console.log 'by_quantity', (if f1.quantity < f2.quantity then -1 else 1), f1.quantity, f2.quantity
      return (if f1.quantity < f2.quantity then -1 else 1)

    # mod1
    if f1.modifier1 != f2.modifier1
      # console.log 'by_mod1'
      if f1.modifier1.length == 0
        return -1
      if f2.modifier1.length == 0
        return 1

    # mod1
    if f1.modifier2 != f2.modifier2
      # console.log 'by_mod2'
      if f1.modifier2.length == 0
        return -1
      if f2.modifier2.length == 0
        return 1

    # year
    if f1.year != f2.year
      # console.log 'by_year', (if f1.year > f2.year then -1 else 1), f1.year, f2.year
      return (if f1.year > f2.year then -1 else 1)

    # category
    if f1.categoryId != f2.categoryId
      if f1.categoryId == 'MEDICARE'
        return -1
      if f2.categoryId == 'MEDICARE'
        return 1
      if f1.categoryId == 'SELFPAY'
        return 1
      if f2.categoryId == 'SELFPAY'
        return -1
    
    # ranked the same if it makes it this far
    0