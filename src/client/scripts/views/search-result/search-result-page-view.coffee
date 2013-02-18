define [
  'jquery'
  'models/base/model'
  'views/base/page-view'
  'views/search-result/search-results-view'
  'views/search-result/search-result-doctype-view'
], ($, Model, PageView, SearchResultsView,  SearchResultDoctypeView) ->
  'use strict'

  class SearchResultPageView extends PageView
    container: '#main-content'
    tagName: 'div'

    initialize: ->
      super

    renderSubviews: -> 
      super
      @search_results_view = new SearchResultsView
        collection: @collection
        container: @$el
        itemView: @options.resultItemView
      @search_results_view.render()
      
      @doctype_model = new Model 
      console.log(@options.contextInfo.query)
      @doctype_model.set
        searchContextId: @options.contextInfo.searchContextId
        stageId: @options.contextInfo.stageId
        query: encodeURIComponent(@options.contextInfo.query)
       
      @search_result_doctype_view = new SearchResultDoctypeView
        model: @doctype_model
          
