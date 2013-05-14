define [
  'jquery'
  'config'
  'models/base/model'
  'views/base/view'
  'text!views/templates/search/trail.hbs'
], ($,
    config,
    SearchTrail,
    View,
    template) ->
  'use strict'

  class SearchTrailView extends View
    template: template
    autoRender: false
    model: new SearchTrail
    className: 'twelve columns'

    initialize: ->
      super
      console.log(@)
      @listenTo @model, 'change', =>
        @render()

      @model.url = config.api.versionRoot + "/getSearchTrail?sctxt=#{@options.searchContextId}"
      @model.fetch()

    attach: ->
      super
      @$('li[stage="' + @options.stageId + '"] ul').addClass('active')

      nextTrail = (stageId) =>
        query = @model.get('trail')[stageId]['query']
        @publishEvent '!router:route', "searchtrail/web/" +
          "#{@options.searchContextId}/" +
          "#{stageId}/#{query}"

      @delegate 'click', '.next', (event) =>
        stageId = parseInt(@options.stageId) + 1
        nextTrail(stageId)

      @delegate 'click', '.prev', (event) =>
        stageId = parseInt(@options.stageId) - 1
        nextTrail(stageId)

      @delegate 'click', 'ul.keywords', (event) =>
        event.stopPropagation()
        event.preventDefault()
        stageId = $(event.target).parents("li[stage]").attr('stage')
        nextTrail(parseInt(stageId))