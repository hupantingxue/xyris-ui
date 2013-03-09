define [
  'views/context-keyword/keywords-page-view'
], (ContextKeywordsPageView) ->
  'use strict'

  class SearchContextKeywordsPageView extends ContextKeywordsPageView
    initialize: ->
      @searchContextId = @options.newSearchContext.searchContextId
      @stageId = @options.newSearchContext.stageId
      super

    attach: ->
      super
      @subscribeEvent 'searchctxt:queryEntered', @initiateKeywordUpdate
