define [
  'views/base/view'
  'text!views/templates/search-summary.hbs'
], (View, template) ->
  'use strict'

  class SearchSummaryView extends View
    autoRender: no
    container: '#search-summary-container'
    template: template

    initialize: ->
      super
      @model.on 'change', @render
      @subscribeEvent 'searchSummary:show', (attributes) =>
        @model.clear(silent: yes)
        @model.set attributes
      
