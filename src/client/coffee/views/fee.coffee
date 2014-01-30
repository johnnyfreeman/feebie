window.FF.Views.Fee = Marionette.ItemView.extend(
  className: 'fee'
  template: '#tplFee'
  # ui:
  #   copyBtns: '.copy-to-clipboard'

  # initialize: ->
  #   @listenTo @model, 'change', _.bind(@render, this)
  #   @listenTo @model, 'change:coInsurance', _.bind(@coInsuranceChangeNotification, this)
  #   return

  # onRender: (e) ->
  #   setTimeout _.bind(@zclip, this), 0
  #   return

  
  # # zclip
  # zclip: ->
  #   $copyBtn = @ui.copyBtns
  #   if $copyBtn.length # && !this.zclipped
  #     $copyBtn.zclip
  #       path: 'assets/jquery-zclip/ZeroClipboard.swf'
  #       copy: ->
  #         $(this).prev('.amount').text()

  #       afterCopy: ->
  #         copied = $(this).find('.copied')[0]
  #         TweenLite.to copied, 0.2,
  #           left: 0
  #           onComplete: ->
  #             TweenLite.to copied, 0.2,
  #               left: 348
  #               delay: 2
  #               onComplete: ->
  #                 $(copied).css 'left', -348
  #                 return

  #             return

  #         return

  #   return

  # coInsuranceChangeNotification: ->
  #   message = 'The co-insurance multiplier has been changed to <em>' + @model.get('coInsuranceMultiplier') + '%</em>.'
  #   window.FF.notificationsRegion.show new window.FF.Views.NotificationInfo(message: message)
  #   return
)
