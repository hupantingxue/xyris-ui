define [
  'views/base/view'
  'text!views/templates/search-result-doctype.hbs'
], (View, template) ->
  'use strict'

  class SearchResultDoctypeView extends View
    autoRender: yes
    template: template
    container: '#left-sidebar'
    containerMethod: 'html'

    initialize: ->
      super

