define [
  'jquery'
  'views/base/view'
  'views/search/result/discover-more-view'
  'text!views/templates/search-result-entry/web-entry-detail.hbs'
], ($,
    View,
    DiscoverMoreView,
    template) =>
  'use strict'

  class WebEntryDetailView extends View
    tagName: 'div'
    template: template
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
          category: 'web'
          query: @options.query
          entryId: @model.get('id')

        @listenTo view, 'addedToDOM', =>
          @$('.discover-cont').show()
