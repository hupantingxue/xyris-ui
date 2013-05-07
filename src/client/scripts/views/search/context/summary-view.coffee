define [
  'jquery'
  'views/base/view'
  'models/base/model'
  'text!views/templates/search-context-summary.hbs'
], ($,
    View,
    Model,
    template) ->
  'use strict'

  class SearchContextSummaryView extends View
    template: template
    containerMethod: 'html'
    tagName: 'div'
    className: 'twelve columns'
    autoRender: false

    initialize: ->
      super
      # FilterKeywords are to be retrieved and stored in
      # SearchContext Object will be retrieved using publishEvent
      @publishEvent 'searchContext:getCurrentSearchContext',
        @options.searchContextId,
        @options.stageId,
        @options.query,
        (currentSearchContext) =>

          contextKeywords = []
          # validate currentSearchContext.query info with that passed in options
          # and redirect if different

          for keyword in currentSearchContext.contextKeywords
            contextKeywords.push keyword

          @model = new Model
            query: $.trim(decodeURIComponent(@options.query))
            contextKeywords: contextKeywords

          @render()

    attach: ->
      super
      # [FIX ME]
      @delegate 'click', '.sc-summary-icon', (event) =>
        @publishEvent 'searchctxt:show', {}