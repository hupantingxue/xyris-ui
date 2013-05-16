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
      console.log(@)
      # FilterKeywords are to be retrieved and stored
      # SearchContext Object will be retrieved using publishEvent
      @publishEvent 'searchContext:getCurrentSearchContext',
        @options.searchContextId,
        @options.stageId,
        @options.query,
        (currentSearchContext) =>

          contextKeywords = []
          # validate currentSearchContext.query info with that passed in options
          # and redirect if different

          if 'contextKeywords' of currentSearchContext
            for id, keyword of currentSearchContext.contextKeywords
              contextKeywords.push keyword

          query = currentSearchContext && @options.query
          @model = new Model
            query: $.trim(decodeURIComponent(query))
            contextKeywords: contextKeywords

          @render()

    attach: ->
      super
      @$('.sc-summ-action').removeClass('active')
      @$('#summ-show-' + @options.state).addClass('active')
      @delegate 'click', '.sc-summary-icon', (event) =>
        @publishEvent '!router:route', ""

      @delegate 'click', '#summ-show-result', (event) =>
        @publishEvent '!router:route', "search/#{@options.category}/" +
          "#{@options.searchContextId}/" +
          "#{@options.stageId}/#{@options.query}"

      @delegate 'click', '#summ-show-trail', (event) =>
        @publishEvent '!router:route', "searchtrail/#{@options.category}/" +
          "#{@options.searchContextId}/" +
          "#{@options.stageId}/#{@options.query}"