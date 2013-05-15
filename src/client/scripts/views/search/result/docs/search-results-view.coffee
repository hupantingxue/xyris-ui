define [
  'config'
  'models/base/collection'
  'models/search/result/docs-entry'
  'views/search/result/base/search-results-view'
  'views/search/result/docs/result-entry-view'
], (config,
    SearchResults,
    SearchResultEntry,
    BaseSearchResultsView,
    SearchResultEntryView) ->
  'use strict'

  class DocsSearchResultsView extends BaseSearchResultsView
    itemView: SearchResultEntryView
    searchCat: 'docs'

    initialize: ->
      @baseUrl = config.api.baseUrl
      @collection = new SearchResults null, model: SearchResultEntry
      @collection.url = @baseUrl + "/search/docs" +
                        "/#{@options.searchContextId}" +
                        "/#{@options.stageId}" +
                        "/#{@options.query}"

      # Call super after instantiating collection because parent super
      # assign listeners to collection
      super
      @collection.fetch()