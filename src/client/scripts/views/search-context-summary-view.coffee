define [
  'views/base/view'
  'text!views/templates/search-context-summary.hbs'
], (View, template) ->
  'use strict'

  class SearchContextSummaryView extends View
    template: template
    autoRender: no
    containerMethod: 'html'
    tagName: 'nav'
    className: 'top-bar'
  
    initialize: ->
      super

    render: ->
      super

    afterRender: ->
      super
      @delegate 'click', '.sc-summary-icon', (event) =>
        @publishEvent 'searchctxt:show', {}
    
