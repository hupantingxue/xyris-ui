define [
  'jquery'
  'backbone'
  'models/base/model'
  'views/base/page-view'
  'views/search-context-summary-view'
  'views/search-context-query-view'
  'views/search-context-suggest-page-view'
  'views/search-context-doctype-view'
  'text!views/templates/search-context-page.hbs'
], ($, Backbone, Model, PageView, SearchContextSummaryView, SearchContextQueryView, SearchContextSuggestPageView, SearchContextDoctypeView, template) ->
  'use strict'
  
  class SearchContextPageView extends PageView 
    template: template
    container: '#search-context'
    tagName: 'div'
    id: 'search-context-container'
    className: 'twelve columns container'
 
    initialize: ->
      super

    renderSubviews: -> 
      super
      @search_context_query_view = new SearchContextQueryView
        model: @model
        container: @$('#search-context-query')
      @search_context_query_view.render()

      @search_result_doctype_view = new SearchContextDoctypeView
        model: @model
        container: @$('#search-options')

      @search_context_suggest_page_view = new SearchContextSuggestPageView
      
      @subscribeEvent 'searchctxt:queryEntered', (attributes) => 
        @$el.css('margin-top', '0px')

      @sc_summary = new Model
      @sc_summary_view = new SearchContextSummaryView
        model: @sc_summary
        container: $('#sc-summary')   
         
      @subscribeEvent 'searchctxt:querySubmitted', (attributes) =>
        $('#search-context').addClass('off-page').removeClass('on-page') 
        filterKeywordLength = 0
        if attributes.filterKeyword?
          @sc_summary.set 'filterKeyword', attributes.filterKeyword
          filterKeywordLength = attributes.filterKeyword.length

        query = if attributes.query.length >= (48 - filterKeywordLength) then attributes.query.substring(0, 48 - filterKeywordLength) + '...' else attributes.query

        @sc_summary.set('query', query)
        @sc_summary.set('altQuery', attributes.query)
        @sc_summary.set('ctxtType', 'search') 
        @sc_summary_view.render()   

      @subscribeEvent 'searchctxt:show', (attributes) =>
        $('.on-page').removeClass('on-page').addClass('off-page')
        $('#search-context').addClass('on-page').removeClass('off-page')
        
