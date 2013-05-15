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
    initialize: ->
      super
      @url = config.api.baseUrl
      @subscribeEvent 'matchRoute', (route, params, options) =>
        @model = new SearchContext if ! @model?

        window.model = @model
        # If route is search_result it should contain
        # both searchContextId and stageId
        #
        # Get all information of the stage and store in
        # searchContext as the current stage
        if searchHelper.isValidRouteName(route.name)
          if params.searchContextId? and params.stageId? and params.query
            # fetching the currentSearchContextInfo
            @publishEvent 'searchContext:getCurrentSearchContext',
              params.searchContextId,
              params.stageId,
              params.query
              (currenSearchContext) =>
            @model.deleteNewSearchContext()

        else if route.name == 'index'
          console.log('index inside')
          # here it require a new search Context id and first stage id
          # to be fetched to initiate
          # the searchContext info is stored in a new stage which becomes
          # active as soon as user searches
          @model.url = @url + '/searchctxt/new'

          @model.on 'change:newSearchContext', (thisModel, newSearchContext) =>
            @compose 'sc-search-context-page', SearchContextPageView,
                region: 'searchContext'
                autoRender: true
                newSearchContext: newSearchContext

            @compose 'sc-search-context-query', SearchContextQueryView,
                region: 'searchContextQuery'
                autoRender: true
                newSearchContext: newSearchContext

            @compose 'sc-context-keywords', SearchContextKeywordsPageView,
                region: 'contextKeywordsSuggest'
                autoRender: true
                newSearchContext: newSearchContext

          @model.fetch()
        else
          throw new Error "invalid route.name #{route.name}"
          console.log('[ERROR] new case')
          console.log(route)
          console.log(params)
          console.log(options)
