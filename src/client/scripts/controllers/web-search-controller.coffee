define [
  'jquery'
  'controllers/search-result-controller'
  'views/web/search-results-view'
], ($,
    SearchResultController,
    WebSearchResultsView) ->

  'use strict'

  class WebSearchController extends SearchResultController

     show: (params) ->
      # Data included in params
      # params.cat = 'web'
      # params.searchContextId
      # params.stageId
      # params.query

      @compose 'sr-search-results', WebSearchResultsView,
        region: 'searchResults'
        searchContextId: params.searchContextId
        stageId: params.stageId
        category: params.cat
        query: params.query
        filterKeyword: params.filterKeyword if params.filterKeyword?