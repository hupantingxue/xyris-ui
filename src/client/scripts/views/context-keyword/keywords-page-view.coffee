define [
  'underscore'
  'jquery'
  'config'
  'chaplin/lib/delayer'
  'models/context-keyword/keyword'
  'models/context-keyword/keywords'
  'views/base/page-view'
  'views/context-keyword/keywords-view'
  'views/context-keyword/keyword-entry-view'
  'text!views/templates/context-keyword/keyword-page.hbs'
], (_,
    $,
    config,
    Delayer,
    Keyword,
    Keywords,
    PageView,
    KeywordsView,
    KeywordEntryView,
    template) ->

  'use strict'

  class KeywordsPageView extends PageView
    template: template

    _(@prototype).extend Delayer

    initialize: ->
      super
      @url = config.api.versionRoot
      @collection = new Keywords null, model: Keyword
      @render()

    updateKeywords: (query, keyid) ->
      url =
        @url +
        "/searchctxt/get/keyword?" +
        "scid=#{@model.get('searchContextId')}" +
        "&stgid=#{@model.get('stageId')}"

      if query?
        return () =>
          @collection.url = url + "&query=#{query}"
          @collection.fetch()
      else if keyid?
        return () =>
          @collection.url = url + "&keyid=#{keyid}"
          @collection.fetch()

    renderSubviews: ->
      super
      @keywords_view = new KeywordsView
        collection: @collection
        container: @$('#ctxt-keyword-result-container')
        itemView: KeywordEntryView
        query: @options.query

      @keywords_view.render()

      @subscribeEvent 'searchctxt:queryEntered', (attributes) =>
        if attributes.query != ''
          query = encodeURIComponent(attributes.query)
          @setTimeout("updateKeywords", 400, @updateKeywords(query, null))
        else
          @collection.reset()

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
