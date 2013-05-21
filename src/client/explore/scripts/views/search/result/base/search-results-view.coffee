define [
  'views/base/collection-view'
], (CollectionView) ->
  'use strict'

  class BaseSearchResultsView extends CollectionView
    className: 'search-results twelve columns'
    tagName: 'div'

    initialize: ->
      super

      @subscribeEvent 'searchresultentry:clicked', (attributes) =>
        model = attributes.model
        @publishEvent '!router:route',
          "search/#{@searchCat}/#{@options.searchContextId}/#{@options.stageId}/#{@options.query}/detail/#{model.id}",
          model: model
          scrollPos: attributes.scrollPos