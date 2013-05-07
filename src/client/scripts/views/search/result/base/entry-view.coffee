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