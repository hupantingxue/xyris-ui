define [
  'config'
  'models/base/model'
  'chaplin/lib/event_broker'
], (config,
    Model,
    EventBroker) ->
  'use strict'

  class SearchContext extends Model
    _.extend @prototype, EventBroker

    initialize: ->
      super
      @baseUrl = config.api.baseUrl

      @subscribeEvent 'searchCtxt:persistCtxtKeyword', @persistCtxtKeyword
      @subscribeEvent 'searchCtxt:sync', @syncSearchCtxt
      @subscribeEvent 'searchContext:navigateToNext', @navigateToNext

    syncSearchCtxt: (searchContextId, stageId, query, callback) ->
      query = encodeURIComponent(query)
      @url = @baseUrl + '/searchctxt/sync' +
            "/#{searchContextId}" +
            "/#{stageId}" +
            "/#{query}"
      @fetch
        success: () =>
          callback(@attributes) if callback

    navigateToNext: (contextKeywords, cat) =>
      @publishEvent '!router:route', "search/#{cat}/" +
        "#{@currentSearchContext.searchContextId}/" +
        "54657/#{@currentSearchContext.query}"

    persistCtxtKeyword: (attributes, callback) =>
      if attributes.keyid of @attributes.contextKeywords
          callback(false)
          return

      @attributes.contextKeywords[attributes.keyid] = attributes.keyword
      @url = @baseUrl + '/searchctxt/add/ctxtkeyword' +
        "/#{@attributes.searchContextId}" +
        "/#{@attributes.stageId}" +
        "/#{attributes.keyword}" +
        "/#{attributes.keyid}"

      @fetch(
        success: (thisModel, response, options) =>
          callback response.persisted
      )

    new: (callback) ->
      @url = @baseUrl + '/searchctxt/new'
      @fetch
        success: () =>
          callback(@attributes) if callback

