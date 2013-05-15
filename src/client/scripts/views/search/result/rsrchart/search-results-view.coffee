define [
  'config'
  'models/base/collection'
  'models/search/result/rsrchart-entry'
  'views/search/result/base/search-results-view'
  'views/search/result/rsrchart/result-entry-view'
], (config,
    SearchResults,
    SearchResultEntry,
    BaseSearchResultsView
    SearchResultEntryView) ->
  'use strict'

  class RsrchartSearchResultsView extends BaseSearchResultsView
    itemView: SearchResultEntryView
    searchCat: 'rsrchart'

    initialize: ->
      @baseUrl = config.api.baseUrl
      @collection = new SearchResults null, model: SearchResultEntry
      @collection.url = @baseUrl + "/search/rsrchart" +
                        "/#{@options.searchContextId}" +
                        "/#{@options.stageId}" +
                        "/#{@options.query}"


      # Call super after instantiating collection because parent super
      # assign listeners to collection
      super
      @collection.fetch()