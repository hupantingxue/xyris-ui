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

    attach: ->
      super
      @delegate 'click', 'h6', (event) =>
        @publishEvent 'ctxtkeyword:clicked',
          keyword: @model.get('name')
          keyid: @model.get('keyid')

      @delegate 'click', 'span', (event) =>
        @publishEvent 'ctxtkeyword:selected',
          keyword: @model.get('name')
          keyid: @model.get('keyid')
