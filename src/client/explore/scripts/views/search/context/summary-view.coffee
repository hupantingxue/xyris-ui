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

      @publishEvent 'searchCtxt:sync',
        @options.searchContextId,
        @options.stageId,
        @options.query,
        (searchContext) =>
          contextKeywords = []
          for id, keyword of searchContext.contextKeywords
            contextKeywords.push keyword

          query = searchContext.query
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