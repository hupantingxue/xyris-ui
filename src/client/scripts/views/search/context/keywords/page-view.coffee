define [
  'views/context-keyword/keywords-page-view'
], (ContextKeywordsPageView) ->
  'use strict'

  class SearchContextKeywordsPageView extends ContextKeywordsPageView
    initialize: ->
      super
      @searchContextId = @options.searchContext.searchContextId
      @stageId = @options.searchContext.stageId

    attach: ->
      super
      @subscribeEvent 'searchctxt:queryEntered', @initiateKeywordUpdate
