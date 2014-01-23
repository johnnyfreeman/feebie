FF.Models.Fees = Backbone.Model.extend(
  defaults: {}
  
  # allowable: '',
  # coInsurance: '',
  # selfPay: '',
  # fac: false,
  # modifier1: '',
  # modifier2: '',
  # quantity: 1
  initialize: ->
    
    # allowable
    allowable = @get('allowable')
    @set 'allowable', FF.Number.toMoney(allowable)
    
    # coinsurance
    @calculateCoInsurance()
    
    # self pay
    selfPay = (if @get('selfPay') is 'undefined' then allowable * @collection.config.selfPayMultiplier else @get('selfPay'))
    @set 'selfPay', FF.Number.toMoney(selfPay)
    
    # fac
    fac = @get('fac')
    @set 'fac', (if fac then 'Facility' else 'Non-Facility')
    
    # modifier1
    @set 'modifier1', 'none'  unless @get('modifier1')
    
    # modifier2
    @set 'modifier2', 'none'  unless @get('modifier2')
    @listenTo @collection, 'change:config:coInsuranceMultiplier', _.bind(@calculateCoInsurance, this)
    return

  calculateCoInsurance: ->
    newMultiplier = @collection.config.coInsuranceMultiplier
    newValue = FF.Number.fromMoney(@get('allowable')) * newMultiplier
    @set
      coInsuranceMultiplier: parseInt(newMultiplier * 100)
      coInsurance: FF.Number.toMoney(newValue)

    return
)
