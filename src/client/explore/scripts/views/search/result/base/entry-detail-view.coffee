define [
  'jquery'
  'views/base/view'
   'views/search/result/discover-more-view'
], ($,
    View,
    DiscoverMoreView) =>
  'use strict'

  class BaseEntryDetailView extends View
    tagName: 'div'
    containerMethod: 'html'

    initialize: ->
      super
      if !@autoRender
        @listenTo @model, 'change', =>
          @render()
      $(window).scrollTop(@options.scrollPos)

    attach: ->
      super
      @$el.css(
        top: '75px'
        position: 'fixed'
        height: '100%'
      )

      @subscribeEvent 'searchentryoption:summary', (attributes) =>
        @$(".entry-content").show()
        @$('.deep-dive-cont').hide()
        @$('.discover-cont').hide()

      @subscribeEvent 'searchentryoption:discover', (attributes) =>
        @$(".entry-content").hide()
        @$('.deep-dive-cont').hide()
        view = new DiscoverMoreView
          autoRender: false
          container: @$('.discover-cont')
          searchContextId: @options.searchContextId
          stageId: @options.stageId
          category: @options.category
          query: @options.query
          entryId: @model.get('id')

        @listenTo view, 'addedToDOM', =>
          @$('.discover-cont').show()
