define [
  'config'
  'jquery'
  'views/base/page-view'
  'models/base/model'
  'models/base/collection'
  'views/search-query-suggest-view'
  'views/suggest-query-entry-view'
], (config, $,  PageView, Model, Collection, SearchQuerySuggestView, SuggestQueryEntryView) ->
  'use strict'
 
  class SearchContextSuggestPageView extends PageView
    container: '#search-suggestions'

    initialize: ->
      super
      @hidden = true
      @render()

    renderSubviews: ->
      super
      @url = config.api.versionRoot

      @suggest_queries = new Collection null, model: Model

      @subscribeEvent 'searchctxt:queryEntered', (attributes) =>
        if @hidden
          $('#search-suggestions').show()  
        else
          @hidden = true

        @suggest_queries.url = @url + '/suggest/query/' + encodeURIComponent(attributes.query)  
 
        @search_query_suggest_view.dispose() if @search_query_suggest_view?
 
        @search_query_suggest_view = new SearchQuerySuggestView
          collection: @suggest_queries
          container: $('#search-query-suggest')
          itemView: SuggestQueryEntryView

        @suggest_queries.fetch()
