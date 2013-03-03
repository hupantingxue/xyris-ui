define [
  'jquery'
  'views/base/view'
  'text!views/templates/web-result-entry.hbs'
], ($, View, template) ->
  'use strict'

  class WebResultEntryView extends View
    template: template
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

      @$el.hover((event)=>
        @$el.addClass('hover')
      (event) =>
        @$el.removeClass('hover')
      )
