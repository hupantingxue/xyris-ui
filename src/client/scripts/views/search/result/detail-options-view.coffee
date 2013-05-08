define [
  'views/base/view'
  'text!views/templates/search-result/detail-options.hbs'
], (View,
    template) ->
  'use strict'

  class EntryDetailOptionsView extends View
    template: template

    initialize: ->
      super
      @$el.css(
        top: '75px'
        position: 'fixed'
      )

    attach: ->
      super
      @$('.summary').addClass('active')

      @delegate 'click', '.summary', (event) =>
        event.stopPropagation()
        event.preventDefault()
        @$('.active').removeClass('active')
        @$('.summary').addClass('active')
        @publishEvent 'searchentryoption:summary', {}

      @delegate 'click', '.read', (event) =>
        event.stopPropagation()
        event.preventDefault()
        window.open(@options.model.get('url')).focus()

      @delegate 'click', '.discover', (event) =>
        event.stopPropagation()
        event.preventDefault()
        @$('.active').removeClass('active')
        @$('.discover').addClass('active')
        @publishEvent 'searchentryoption:discover', {}


      @subscribeEvent 'searchresultentry:clicked', (attributes) =>
        model = @options.model = attributes.model
        @$('.active').removeClass('active')
        @$('.summary').addClass('active')