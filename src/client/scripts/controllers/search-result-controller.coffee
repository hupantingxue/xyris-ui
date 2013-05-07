define [
  'jquery'
  'controllers/base/controller'
  'views/search/result/page-view'
  'views/search/options-view'
  'views/search/context/summary-view'
  'views/search/result/keywords/page-view'
], ($,
    Controller,
    SearchResultPageView,
    SearchOptionsView,
    SearchContextSummaryView,
    SearchResultKeywordsPageView) ->

  'use strict'

  # Common SearchResultContainer to handle route for showing search
  # results
  #
  # Guidelines:
  # all composed elements' name should start with 'sr-'
  # [Abstract class child class to implement show]
  class SearchResultController extends Controller

    initialize: ->
      # Make show an abstract function
      if !@show?
        throw new Error "Child class extending SearchResultController should implement show"
      super

    beforeAction:
      '.*': (params, options, previous) ->
      'show': (params, options, previous) ->
        console.log(params.cat)
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