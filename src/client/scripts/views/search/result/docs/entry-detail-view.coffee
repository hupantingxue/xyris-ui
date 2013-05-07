define [
  'jquery'
  'views/base/view'
  'text!views/templates/search-result-entry/docs-entry-detail.hbs'
], ($,
    View,
    template) =>
  'use strict'

  class DocsEntryDetailView extends View
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
        left: @$el.offset().left
        top: '75px'
        position: 'fixed'
      )
