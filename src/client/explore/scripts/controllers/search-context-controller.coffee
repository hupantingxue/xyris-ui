define [
  'config'
  'lib/search-helper'
  'controllers/base/controller'
  'models/search/context/search-context'
  'views/search/context/page-view'
  'views/search/context/query-view'
  'views/search/context/keywords/page-view'
], (config,
    searchHelper,
    Controller,
    SearchContext,
    SearchContextPageView,
    SearchContextQueryView,
    SearchContextKeywordsPageView) ->
  'use strict'

  # SearchContextController is the default controller
  # that gets intiated for the first time and then persist
  #
  # Important tasks it does are
  # ---------------------------
  # - Instantiate and intialize SearchContext object
  class SearchContextController extends Controller
    initialize: (options)->
      super
      @searchContext = options.model # alias

      @url = config.api.baseUrl
      @subscribeEvent 'matchRoute', (route, params, options) =>

        # if url contains searchContextId and stageId then sync
        # SearchContext with the data on server
        # else get a new searchContext
        if 'searchContextId' in params and 'stageId' in params
          @searchContext.syncSearchCtxt(
            params.searchContextId,
            params.stageId,
            params.query,
            () =>
          )

        if route.name == 'index'
          @searchContext.new (attr) =>
            console.log(attr)
            @compose 'sc-search-context-page', SearchContextPageView,
                region: 'searchContext'
                autoRender: true
                searchContext: attr

            @compose 'sc-search-context-query', SearchContextQueryView,
                region: 'searchContextQuery'
                autoRender: true
                searchContext: attr

            @compose 'sc-context-keywords', SearchContextKeywordsPageView,
                region: 'contextKeywordsSuggest'
                autoRender: true
                searchContext: attr
