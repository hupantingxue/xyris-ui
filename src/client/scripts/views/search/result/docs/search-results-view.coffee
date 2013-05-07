define [
  'config'
  'models/base/collection'
  'models/search/result/docs-entry'
  'views/base/collection-view'
  'views/search/result/docs/result-entry-view'
], (config,
    SearchResults,
    SearchResultEntry,
    CollectionView,
    SearchResultEntryView) ->
  'use strict'

  # [Functionality to add]
  # on click of search result compose the result entry
  # detail to searchResultDetail region.
  class DocsSearchResultsView extends CollectionView
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

      @subscribeEvent 'searchresultentry:clicked', (attributes) =>
        model = attributes.model
        @publishEvent '!router:route',
          "search/docs/#{@options.searchContextId}/#{@options.stageId}/#{@options.query}/detail/#{model.id}",
          model: model
          scrollPos: attributes.scrollPos