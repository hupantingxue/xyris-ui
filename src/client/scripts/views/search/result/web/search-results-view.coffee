define [
  'config'
  'models/base/collection'
  'models/search/result/web-entry'
  'views/search/result/base/search-results-view'
  'views/search/result/web/result-entry-view'
], (config,
    SearchResults,
    SearchResultEntry,
    BaseSearchResultsView,
    SearchResultEntryView) ->
  'use strict'

  class WebSearchResultsView extends BaseSearchResultsView
    itemView: SearchResultEntryView
    searchCat: 'web'

    initialize: ->
      @baseUrl = config.api.baseUrl
      @collection = new SearchResults null, model: SearchResultEntry
      # Call super after instantiating collection because parent super
      # assign listeners to collection
      super
      @collection.url = @baseUrl + "/search/web" +
                        "/#{@options.searchContextId}" +
                        "/#{@options.stageId}" +
                        "/#{@options.query}"

      if(@options.state == 'trail')
        @collection.url = @baseUrl +
                          "/searchtrail" +
                          "/results/web" +
                          "/#{@options.searchContextId}" +
                          "/#{@options.stageId}"

      @collection.fetch()