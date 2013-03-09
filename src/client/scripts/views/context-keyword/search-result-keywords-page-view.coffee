define [
  'views/context-keyword/keywords-page-view'
], (ContextKeywordsPageView) ->
  'use strict'

  class SearchResultKeywordsPageView extends ContextKeywordsPageView
    initialize: ->
      @searchContextId = @options.searchContextId
      @stageId = @options.stageId
      @storedQueryAttributes =
        query: @options.query
      super
