define [
  'config'
  'models/search/search-results'
  'models/web/result-entry'
  'views/base/collection-view'
  'views/web/result-entry-view'
], (config,
    SearchResults,
    SearchResultEntry,
    CollectionView,
    SearchResultEntryView) ->
  'use strict'

  class SearchResultsView extends CollectionView
    className: 'search-results twelve columns'
    tagName: 'div'
    itemView: SearchResultEntryView

    initialize: ->
      @baseUrl = config.api.versionRoot
      @collection = new SearchResults null, model: SearchResultEntry
      @collection.url = @baseUrl + "/search/web?" +
                        "q=#{@options.query}" +
                        "&ctxtid=#{@options.searchContextId}" +
                        "&stageId=#{@options.stageId}"

      # Call super after instantiating collection because parent super
      # assign listeners to collection
      super
      @collection.fetch()
