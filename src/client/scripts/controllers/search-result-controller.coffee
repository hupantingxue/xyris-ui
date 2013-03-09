define [
  'jquery'
  'controllers/base/controller'
  'views/search-result/search-result-page-view'
  'views/search-result/search-options-view'
  'views/search-context/search-context-summary-view'
  'views/context-keyword/search-result-keywords-page-view'
  'views/search-result/search-results-view'
], ($,
    Controller,
    SearchResultPageView,
    SearchOptionsView,
    SearchContextSummaryView,
    SearchResultKeywordsPageView,
    SearchResultsView) ->

  'use strict'

  # Common SearchResultContainer to handle route for showing search
  # results
  #
  # Guidelines:
  # all composed elements' name should start with 'sr-'
  class SearchResultController extends Controller

    beforeAction:
      '.*': (params, options, previous) ->
      'show': (params, options, previous) ->
        # Start composing the page with common elements

        # Create SearchResultPageView which create basic layout in
        # main region (defined in BaseLayoutView) and then create regions in it
        # Regions include -
        #   searchOptions
        #   searchContextSummary
        #   searchResults
        #   contextKeywords
        #   searchResultDetail
        #   searchResultOptions
        @compose 'sr-search-result', SearchResultPageView,
          region: 'main'
          autoRender: true

        @compose 'sr-search-options', SearchOptionsView,
          region: 'searchOptions'
          searchContextId: params.searchContextId
          stageId: params.stageId
          category: params.cat
          query: params.query
          autoRender: true

        @compose 'sr-search-context-summary', SearchContextSummaryView,
          region: 'searchContextSummary'
          searchContextId: params.searchContextId
          stageId: params.stageId
          category: params.cat
          query: params.query

        @compose 'sr-context-keywords', SearchResultKeywordsPageView,
          region: 'contextKeywords'
          searchContextId: params.searchContextId
          stageId: params.stageId
          category: params.cat
          query: params.query
          autoRender: true

    show: (params) ->
      # Data included in params
      # params.cat = ['web', 'rsrchart', 'docs']
      # params.searchContextId
      # params.stageId
      # params.query

      # [MODIFY] Use trigger for this purpose
      # Maybe BaseLayoutPageView should decide what to hide and show here
      $('.on-page').removeClass('on-page').addClass('off-page')
      $('#main').addClass('on-page').removeClass('off-page')

      # compose (straightforward compose as it will always require replacing)
      #   SearchResultsView in region searchResults

      @compose 'sr-search-results', SearchResultsView,
        region: 'searchResults'
        searchContextId: params.searchContextId
        stageId: params.stageId
        category: params.cat
        query: params.query
        filterKeyword: params.filterKeyword if params.filterKeyword?
