window.FF.Views.Fees = Marionette.CollectionView.extend

  # item view
  itemView: window.FF.Views.Fee

  # wrap template with div.fees.row
  className: 'fees row'

  collectionEvents:
    change: 'render'

  # ** Override Marionette.CollectionView.showCollection **
  # Internal method to loop through each item in the
  # collection view and show it
  showCollection: () ->
    @collection.each (fee, index) ->
      FeeView = @getItemView fee
      @addItemView fee, FeeView, index unless fee.isHidden()
    , this