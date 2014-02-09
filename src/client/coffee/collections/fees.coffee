window.FB.Collections.Fees = Backbone.Collection.extend
  
  # model
  model: window.FB.Models.Fee

  # fees are always passed
  # to the initialize method
  initialize: (models, options) ->
    _this = this

    # save reference to the code
    # this collection belongs to
    @code = options.code

    # when the code is synced to the
    # server, update this fees collection
    @code.on 'sync', (code) ->
      _this.reset code.get 'fees'

    # find all initial source/clones
    @on 'reset', (fees) ->
      fees.each (fee) ->
        # only non-medicare fees
        return if fee.get('categoryId') is 'MEDICARE'
        # find source fee
        source = fees.findWhere _.extend(fee.getFilterAttrs(), {categoryId:'MEDICARE'})
        # if source is an instance of
        # Fee, add refs to each other
        if source instanceof window.FB.Models.Fee
          fee.source = source
          source.clones.add fee

    # clone medicare fees that didn't have
    # any clones is previous reset callback
    @on 'reset', (fees) ->
      # new fees array
      newFees = []
      # loop through fees
      fees.each (fee) ->
        # clone medicare fees
        return if fee.get('categoryId') isnt 'MEDICARE'
        # if there isn't a coinsurance clone, create one
        if fee.clones.where(categoryId:'COINSURANCE').length is 0
          newFees.push fee.cloneAsCoinsurance()
        # if there isn't a selfpay clone, create one
        if fee.clones.where(categoryId:'SELFPAY').length is 0
          newFees.push fee.cloneAsSelfPay()
    # add new fees to the collection
      fees.add newFees

      # get filter attrs from first fee in the collection
      # then we'll save that as the current filter
    @on 'reset', (fees) ->
      _this.code.filter.set fees.at(0).getFilterAttrs(), {silent: true}

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