define [
  'jquery'
  'config'
  'controllers/search-result-controller'
  'views/search/result/rsrchart/search-results-view'
  'views/search/result/rsrchart/entry-detail-view'
  'views/search/result/detail-options-view'
  'models/search/result/rsrchart-entry'
], ($,
    config,
    SearchResultController,
    SearchResultsView,
    RsrchartEntryDetailView,
    EntryDetailOptionsView,
    RsrchartResultEntry) ->

  'use strict'

  class RsrchartSearchController extends SearchResultController

     show: (params, options) ->
      # Data included in params
      # params.cat = 'rsrchart'
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

       if(params.showDetail == true)
        if !options.model?
          model = new RsrchartResultEntry
          model.set('id', params.id)
          options['model'] = model
          options.model.url = config.api.versionRoot + "/getWebEntry?id=#{params.id}"
          options.model.fetch()

        @publishEvent 'searchResultPage:changeState', {'state': 'search-result-detail-view'}, (success) =>
          @compose 'sr-entry-detail', RsrchartEntryDetailView,
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
      else
        @publishEvent 'searchResultPage:changeState', {'state': 'search-result-view'}, (success) =>
          console.log("changed state now add data")