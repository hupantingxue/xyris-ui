define [
  'config'
  'models/base/model'
  'views/base/view'
  'text!views/templates/search-discover.hbs'
], (config,
    Model,
    View,
    template) ->
  'use strict'

  class DiscoverMoreView extends View
    template: template
    tagName: 'div'
    containerMethod: 'html'
    className: 'discover-more'
    selectedKeys: []

    initialize: ->
      @model = new Model
      super
      @model.url = config.api.baseUrl +
                  "/discover/get/keywords" +
                  "/#{@options.category}" +
                  "/#{@options.entryId}"

      @listenTo @model, 'change', =>
        @render()
      @model.fetch()

    attach: ->
      super
      @delegate 'click', '.explore', (event) =>
        event.stopPropagation()
        event.preventDefault()
        @publishEvent 'searchContext:navigateToNext', @selectedKeys, @options.category

      @delegate 'click', '.discover-keys span', (event) =>
        event.stopPropagation()
        event.preventDefault()
        keyid = @$(event.target).attr('id').substring(8)
        idx = @selectedKeys.indexOf(keyid)
        if idx != -1
          @$(event.target).html('&oplus;').removeClass('red')
          @selectedKeys.splice(idx, 1)
        else
          @$(event.target).html('&ominus;').addClass('red')
          @selectedKeys.push(keyid)
