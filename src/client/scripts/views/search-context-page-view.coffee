define [
  'jquery'
  'config'
  'backbone'
  'models/base/model'
  'views/base/page-view'
  'views/search-context-summary-view'
  'views/search-context-query-view'
  'views/context-keyword/keywords-page-view'
  'text!views/templates/search-context-page.hbs'
], ($,
    config,
    Backbone,
    Model,
    PageView,
    SearchContextSummaryView,
    SearchContextQueryView,
    KeywordsPageView,
    template) ->

  'use strict'

  class SearchContextPageView extends PageView
    template: template
    container: '#search-context'
    tagName: 'div'
    id: 'search-context-page'
    className: 'twelve columns container'

    initialize: ->
      super

    renderSubviews: ->
      super
      @search_context_query_view = new SearchContextQueryView
        model: @model
        container: @$('#search-context-query')
      @search_context_query_view.render()

      @keywords_page_view = new KeywordsPageView
        container: @$('#search-query-suggest')
        model: @model

      @sc_summary = new Model
      @sc_summary_view = new SearchContextSummaryView
        model: @sc_summary
        container: $('#sc-summary')

      @subscribeEvent 'searchctxt:queryEntered', (attributes) =>
        if attributes.query == ""
          @$("#search-hint").show()
          @$("#search-context-suggest").hide()
        else
          @$("#search-hint").hide()
          @$("#search-context-suggest").show()

        query = encodeURIComponent(attributes.query)
        @$('.web a').attr('href',
                          '/search/web/' +
                          @model.attributes.searchContextId + '/' +
                          @model.attributes.stageId + '/' + query)

        @$('.rsrchart a').attr('href',
                               '/search/rsrchart/' +
                               @model.attributes.searchContextId + '/' +
                               @model.attributes.stageId + '/' + query)

        @$('.docs a').attr('href',
                           '/search/docs/' +
                           @model.attributes.searchContextId + '/' +
                           @model.attributes.stageId + '/' + query)

      @subscribeEvent 'searchctxt:querySubmitted', (attributes) =>
        $('#search-context').addClass('off-page').removeClass('on-page')
        filterKeywordLength = 0
        if attributes.filterKeyword?
          @sc_summary.set 'filterKeyword', attributes.filterKeyword
          filterKeywordLength = attributes.filterKeyword.length

        if attributes.query.length >= (48 - filterKeywordLength)
          query = attributes.query.substring(0, 48 - filterKeywordLength) + '...'
        else
          query = attributes.query

        @sc_summary.set('query', query)
        @sc_summary.set('altQuery', attributes.query)
        @sc_summary.set('ctxtType', 'search')
        @sc_summary_view.render()

      # fix it with a better solution
      @subscribeEvent 'searchctxt:show', (attributes) =>
        $('.on-page').removeClass('on-page').addClass('off-page')
        $('#search-context').addClass('on-page').removeClass('off-page')

