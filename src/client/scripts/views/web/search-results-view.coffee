define [
  'config'
  'models/search/search-results'
  'models/web/result-entry'
  'views/base/collection-view'
  'views/web/result-entry-view'
], (config,
    WebSearchResults,
    WebSearchResultEntry,
    CollectionView,
    WebSearchResultEntryView) ->
  'use strict'

  # [Functionality to add]
  # on click of search result compose the result entry
  # detail to searchResultDetail region.
  class WebSearchResultsView extends CollectionView
    className: 'search-results twelve columns'
    tagName: 'div'
    itemView: WebSearchResultEntryView

    initialize: ->
      @baseUrl = config.api.versionRoot
      @collection = new WebSearchResults null, model: WebSearchResultEntry
      @collection.url = @baseUrl + "/search/web?" +
                        "q=#{@options.query}" +
                        "&ctxtid=#{@options.searchContextId}" +
                        "&stageId=#{@options.stageId}"

      # Call super after instantiating collection because parent super
      # assign listeners to collection
      super
      @collection.fetch()