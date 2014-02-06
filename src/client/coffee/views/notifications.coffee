window.FF.Views.Notifications = Marionette.CollectionView.extend

  # item view
  itemView: window.FF.Views.Notification

  # wrap template with div#notifications
  id: 'notifications'
  
  tagName: 'li'

  collectionEvents:
    add: 'render'