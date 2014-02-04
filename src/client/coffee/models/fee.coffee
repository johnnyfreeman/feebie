window.FF.Models.Fee = Backbone.Model.extend
  
  # Fee defaults
  defaults:
    hidden: true

  show: () ->
    @set 'hidden', false

  hide: () ->
    @set 'hidden', true

  isHidden: () ->
    @get 'hidden'

  # reference to another Fee model
  # that was used to create this one
  source: null

  cloneAsCoinsurance: () ->
    coinsuranceFee = @clone()
    coinsuranceFee.set 'categoryId', 'COINSURANCE'
    coinsuranceFee.set 'amount', (@get('amount')*.2).toFixed(2)
    coinsuranceFee.source = this
    coinsuranceFee

  cloneAsSelfPay: () ->
    selfPayFee = @clone()
    selfPayFee.set 'categoryId', 'SELFPAY'
    selfPayFee.set 'amount', (@get('amount')*1.2).toFixed(2)
    selfPayFee.source = this
    selfPayFee

  # get filter attributes
  getFilterAttrs: () ->
    @pick 'fac', 'quantity', 'modifier1', 'modifier2', 'year'