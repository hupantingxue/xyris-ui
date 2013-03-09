define [
  'config'
  'models/base/model'
  'chaplin/lib/event_broker'
], (config,
    Model,
    EventBroker) ->
  'use strict'

  # Search Context holds information about search context
  # At any particular time search context default attributes
  # are searchContextId, current stageId as stageId in attributes
  # query of the current stageId and context keywords associated
  # with the current stage if any.
  #
  # SearchContext can also fetch complete information of other stages
  # if necessary and store in attributes as stageTree
  #
  # SearchContext also stores a temp next stage information. It is created
  # when any of the criteria of advancing a stage is required.
  # It keeps on adding context keywords and new query to this temp next stage
  # and this information is used whenever user does revise search or navigate
  class SearchContext extends Model
    _(@prototype).extend EventBroker

    initialize: ->
      @baseUrl = config.api.versionRoot
      @on 'change:newSearchContext', (thisModel, newSearchContext) =>
        @newSearchContext = newSearchContext

      @on 'change:currentSearchContext', (thisModel, currentSearchContext) =>
        @currentSearchContext = currentSearchContext

      @subscribeEvent 'searchContext:persistContextKeyword', (attributes, callback) =>
        for keyword in @newSearchContext.contextKeywords
          if(keyword.keyid == attributes.keyid)
            callback(false)
            return
        @newSearchContext.contextKeywords.push(attributes)
        @url = @baseUrl + '/searchctxt/addKeyword?' +
               "searchContextId=#{@newSearchContext.searchContextId}" +
               "&stageId=#{@newSearchContext.stageId}" +
               "&keyword=#{attributes.keyword}" +
               "&keyid=#{attributes.keyid}"
        @fetch(
          success: (thisModel, response, options) =>
            @publishEvent 'searchContext:contextKeywordPersisted', attributes.keyid
        )
        callback(true)

      @subscribeEvent 'searchContext:getCurrentSearchContext', (searchContextId, stageId, query, callback) =>
        if @currentSearchContext?
          callback @currentSearchContext
        else
          @url = @baseUrl + '/searchctxt/getinfo?' +
                 "searchContextId=#{searchContextId}" +
                 "&stageId=#{stageId}" +
                 "&query=#{query}"

          @fetch(
            success: (thisModel, response, options) =>
              @currentSearchContext = response.currentSearchContext
              callback @currentSearchContext
          )

      @subscribeEvent 'searchContext:getNewSearchContext', (callback) =>
        callback @newSearchContext

    setCurrentSearchContext: (searchContextId, stageId) ->

    deleteNewSearchContext: () ->
      if @newSearchContext?
        delete @newSearchContext
      if @attributes.newSearchContext?
        delete @attributes.newSearchContext
