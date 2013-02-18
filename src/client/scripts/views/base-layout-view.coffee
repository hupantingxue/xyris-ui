define [
  'views/base/view'
  'text!views/templates/base-layout.hbs'
], (View, template) ->
  'use strict'

  class BaseLayoutView extends View
    autoRender: yes
    template: template
    container: 'body'
    containerMethod: 'prepend'

    initialize: ->
      super
