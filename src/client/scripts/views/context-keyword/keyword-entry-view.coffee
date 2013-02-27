define [
  'jquery'
  'views/base/view'
  'text!views/templates/context-keyword/keyword-entry.hbs'
], ($, View, template) ->
  'use strict'

  class KeywordEntryView extends View
    template: template
    tagName: 'li'
    className: 'ctxt-keyword-entry'

    initialize: ->
      super

    afterRender: ->
      super
      ###
      Removed the background highlighting of context keywords
      index = @model.collection.indexOf(@model)
      opacity = if index <= 8 then 10 - index else 2
      opacity = opacity/10
      @$('div.keyword-background').css({'opacity': "#{opacity}"})
      ###
      @delegate 'click', (event) =>
        @publishEvent 'ctxtkeyword:clicked',
          keyword: @model.get('name')
          keyid: @model.get('keyid')
