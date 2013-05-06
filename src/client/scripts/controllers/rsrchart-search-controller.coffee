define [
  'jquery'
  'controllers/search-result-controller'
  'views/web/search-results-view'
], ($,
    SearchResultController,
    SearchResultsView) ->

  'use strict'

  class WebSearchController extends SearchResultController

     show: (params) ->
      # Data included in params
      # params.cat = 'rsrchart'
      # params.searchContextId
      # params.stageId
      # params.query

      # compose (straightforward compose as it will always require replacing)
      #   SearchResultsView in region searchResults

      @compose 'sr-search-results', SearchResultsView,
        region: 'searchResults'
        searchContextId: params.searchContextId
        stageId: params.stageId
        category: params.cat
        query: params.query
        filterKeyword: params.filterKeyword if params.filterKeyword?