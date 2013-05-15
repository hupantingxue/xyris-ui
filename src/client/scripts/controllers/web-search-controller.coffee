define [
  'jquery'
  'config'
  'controllers/search-result-controller'
  'views/search/result/web/search-results-view'
  'views/search/result/web/entry-detail-view'
  'views/search/result/detail-options-view'
  'models/search/result/web-entry'
], ($,
    config,
    SearchResultController,
    SearchResultsView,
    WebEntryDetailView,
    EntryDetailOptionsView,
    WebResultEntry) ->
  'use strict'

  class WebSearchController extends SearchResultController

     show: (params, options) ->
      # Data included in params
      # params.cat = 'web'
      # params.searchContextId
      # params.stageId
      # params.query
      #
      # Data in options
      # changeURL
      # forceStartup
      # model?
      # path
      # previousControllerName

      # compose (straightforward compose as it will always require replacing)
      #   SearchResultsView in region searchResults

      @compose 'sr-search-results', SearchResultsView,
        region: 'searchResults'
        searchContextId: params.searchContextId
        stageId: params.stageId
        category: params.cat
        query: params.query
        filterKeyword: params.filterKeyword if params.filterKeyword?
        state: params.state

      if(params.state == 'detail')
        if !options.model?
          model = new WebResultEntry
          model.set('id', params.id)
          options['model'] = model
          options.model.url = config.api.baseUrl +
            "/item/get/detail/web/#{params.id}"

          options.model.fetch()

        @publishEvent 'searchResultPage:changeState', {'state': 'search-result-detail-view'}, (success) =>
          @compose 'sr-entry-detail', WebEntryDetailView,
            region: 'searchResultDetail'
            model: options.model
            autoRender: if options.model.has('title') then true else false
            scrollPos: options.scrollPos
            searchContextId: params.searchContextId
            stageId: params.stageId
            category: params.cat
            query: params.query

          @compose 'sr-detail-options', EntryDetailOptionsView,
            region: 'searchResultOptions'
            searchContextId: params.searchContextId
            stageId: params.stageId
            category: params.cat
            query: params.query
            autoRender: true
            model: options.model
      else if(params.state == 'result')
        @publishEvent 'searchResultPage:changeState', {'state': 'search-result-view'}, (success) =>
          console.log("changed state now add data")