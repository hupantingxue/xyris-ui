define [
  'jquery'
  'views/base/view'
], ($, View) ->
  'use strict'

  class BaseResultEntryView extends View
    tagName: 'div'
    className: 'search-result-entry row'
    autoRender: true

    attach: ->
      super
      @$('.snippet').orbit(
        fluid: '16x6'
        timer: 'false'
        animationSpeed: 10
        animation: 'horizontal-push'
        directionalNavRightText: ''
        directionalNavLeftText: ''
      ).trigger('orbit.stop')

      @delegate 'click', '.search-result-desc', (event) =>
        event.stopPropagation()
        event.preventDefault()
        @publishEvent 'searchresultentry:clicked',
          model: @model
          scrollPos: $(window).scrollTop()

        return false