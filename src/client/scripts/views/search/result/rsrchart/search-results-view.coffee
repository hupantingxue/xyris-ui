define [
  'config'
  'models/base/collection'
  'models/search/result/rsrchart-entry'
  'views/base/collection-view'
  'views/search/result/rsrchart/result-entry-view'
], (config,
    SearchResults,
    SearchResultEntry,
    CollectionView,
    SearchResultEntryView) ->
  'use strict'

  # [Functionality to add]
  # on click of search result compose the result entry
  # detail to searchResultDetail region.
  class RsrchartSearchResultsView extends CollectionView
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