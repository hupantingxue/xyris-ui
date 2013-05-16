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
      @subscribeEvent 'searchCtxt:navigateToNext', @navigateToNext

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

    syncSearchCtxt: (searchContextId, stageId, query, callback) ->
      query = encodeURIComponent(query)
      @url = @baseUrl + '/searchctxt/sync' +
            "/#{searchContextId}" +
            "/#{stageId}" +
            "/#{query}"
      @fetch
        success: () =>
          callback(@attributes) if callback

    navigateToNext: (query, contextKeywords, cat) ->
      keywords = contextKeywords.join(':')
      @url = @baseUrl + '/searchctxt/advance' +
             "/#{@attributes.searchContextId}" +
             "/#{query}" +
             "/#{keywords}"
      @fetch
        success: (thisModel, response, options) =>
          @publishEvent '!router:route', "search/#{cat}/" +
            "#{@attributes.searchContextId}/" +
            "#{response.stageId}/" +
            "#{query}"

    new: (callback) ->
      @url = @baseUrl + '/searchctxt/new'
      @fetch
        success: () =>
          callback(@attributes) if callback

