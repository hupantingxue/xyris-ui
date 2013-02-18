define [
  'views/base/view'
  'text!views/templates/app-icon.hbs'
], (View, template) ->
  'use strict'

  class AppIconView extends View
    autoRender: yes
    container: '#app-icon-container'
    template: template
    id: 'app-icon'

    initialize: ->
      super
