define [
  'jquery'
  'config'
  'controllers/base/controller'
  'models/search/search-results'
  'models/web/result-entry'
  'views/search-result/search-result-page-view'
  'views/web/result-entry-view'
  'models/keyword/keywords'
  'models/keyword/keyword'
  'views/keyword/keywords-page-view'
  'views/keyword/keyword-entry-view'
], ($, config, Controller, SearchResults, WebResultEntry, SearchResultPageView, WebResultEntryView, Keywords, Keyword, KeywordsPageView, KeywordEntryView) ->
  'use strict'

  class SearchWebController extends Controller

    show: (params) ->
      $('.on-page').removeClass('on-page').addClass('off-page')
      $('#main').addClass('on-page').removeClass('off-page')

      params.query = $.trim(decodeURIComponent(params.query))
      attributes =
        query: params.query
        toRoute: false
        searchcat: 'web'

      if params.filterKeyword?
        params.filterKeyword = $.trim(decodeURIComponent(params.filterKeyword))
        attributes['filterKeyword'] = params.filterKeyword

      @publishEvent 'searchctxt:querySubmitted', attributes

      @url = config.api.versionRoot
      query = encodeURIComponent(params.query)

      @collection = new SearchResults null, model: WebResultEntry
      @collection.url = @url + "/search/web?q=#{query}&ctxtid=#{params.searchContextId}&stageId=#{params.stageId}"

      @view = new SearchResultPageView
        collection: @collection
        resultItemView: WebResultEntryView
        className: 'web-result-container row'
        id: 'web-result-container'
        contextInfo:
          searchContextId: params.searchContextId
          stageId: params.stageId
          query: params.query

      @collection.fetch()

      @keywords = new Keywords null, model: Keyword
      @keywords.url = @url + "/get/keyword?searchcat=web&ctxtid=#{params.searchContextId}&stageId=#{params.stageId}"

      @keywords_page_view = new KeywordsPageView
        collection: @keywords
        keywordItemView: KeywordEntryView
        query: params.query
      @keywords.fetch()
