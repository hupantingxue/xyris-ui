define [
  'views/base/view'
  'models/base/model'
  'text!views/templates/search-result/search-options.hbs'
], (View,
    Model,
    template) ->
  'use strict'

  class SearchOptionsView extends View
    template: template
    containerMethod: 'html'

    initialize: ->
      super
      @model = new Model
        searchContextId: @options.searchContextId
        stageId: @options.stageId
        query: @options.query

    attach: ->
      super
      @$el.find('li.' + @options.category).addClass('active')
