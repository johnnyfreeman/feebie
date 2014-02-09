window.FB.Models.Fee = Backbone.Model.extend
  
  # Fee defaults
  defaults:
    hidden: true

  # reference to another Fee model
  # that was used to create this one
  source: null

  # reference to Fees collection of cloned Fees
  clones: null

  initialize: (attributes, options) ->
    # make clones a generic collection so
    # that we can use it's methods
    @clones = new window.Backbone.Collection
    
  show: () ->
    @set 'hidden', false

  hide: () ->
    @set 'hidden', true

  isHidden: () ->
    @get 'hidden'

  cloneAsCoinsurance: () ->
    # clone
    coinsuranceFee = @clone()
    # update properties of clone
    coinsuranceFee.set 'categoryId', 'COINSURANCE'
    coinsuranceFee.set 'amount', (@get('amount')*.2).toFixed(2)
    # save refs to each other
    coinsuranceFee.source = this
    @clones.add coinsuranceFee
    # return clone
    coinsuranceFee

  cloneAsSelfPay: () ->
    # clone
    selfPayFee = @clone()
    # update properties of clone
    selfPayFee.set 'categoryId', 'SELFPAY'
    selfPayFee.set 'amount', (@get('amount')*1.2).toFixed(2)
    # save refs to each other
    selfPayFee.source = this
    @clones.add selfPayFee
    # return clone
    selfPayFee

  # get filter attributes
  getFilterAttrs: () ->
    @pick 'fac', 'quantity', 'modifier1', 'modifier2', 'year'