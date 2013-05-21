define [
  'underscore'
  'jquery'
  'config'
  'chaplin/lib/delayer'
  'models/context-keyword/keyword'
  'models/context-keyword/keywords'
  'views/base/view'
  'views/context-keyword/keywords-view'
  'views/context-keyword/keyword-entry-view'
  'text!views/templates/context-keyword/keyword-page.hbs'
], (_,
    $,
    config,
    Delayer,
    Keyword,
    Keywords,
    View,
    KeywordsView,
    KeywordEntryView,
    template) ->

  'use strict'

  class ContextKeywordsPageView extends View
    template: template

    _(@prototype).extend Delayer

    initialize: ->
      super
      @url = config.api.baseUrl
      @collection = new Keywords null, model: Keyword

    initiateKeywordUpdate: (attributes) ->
      if !@keywords_view?
        @storedQueryAttributes = attributes
        return

      if attributes.query != ''
        query = encodeURIComponent(attributes.query)
        @setTimeout("updateKeywords", 400, @updateKeywords(query, null))
      else
        @collection.reset()

    attach: ->
      super
      @subscribeEvent 'ctxtkeyword:show', (attributes, callback) =>
        @renderSubviews()
        callback(true)

    updateKeywords: (query, keyid) ->
      url =
        @url + "/searchctxt/suggest/ctxtkeywords"

      if query?
        return () =>
          @collection.url = url + "/#{query}"
          @collection.fetch()
      else if keyid?
        return () =>
          @collection.url = url + "/#{keyid}"
          @collection.fetch()

    renderSubviews: ->
      if @keywords_view?
        @keywords_view.dispose()

      @$el.find('#ctxt-keyword-result-header').addClass('active')

      @collection.reset()
      @keywords_view = new KeywordsView
        collection: @collection
        container: @$('#ctxt-keyword-result-container')
        itemView: KeywordEntryView
        query: @options.query

      @keywords_view.render()

      if @storedQueryAttributes?
        @initiateKeywordUpdate(@storedQueryAttributes)

      @subscribeEvent 'ctxtkeyword:clicked', (attributes) =>
        @setTimeout("updateKeywords",
                    10,
                    @updateKeywords(null, attributes.keyid))

      @$('#ctxt-keyword-result-container > input').keyup(() =>
        keyword = @$('#ctxt-keyword-result-container > input').val()
        @keywords_view.filter((item, index) =>
          if item.attributes.name  == keyword
            return true
          else
            return false
        (view, included) =>
          if not included
            view.$el.hide()
          else
            view.$el.show()
        )
      )
