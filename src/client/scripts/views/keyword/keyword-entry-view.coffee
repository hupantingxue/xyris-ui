define [
  'views/base/view'
  'text!views/templates/keyword/keyword-entry.hbs'
], (View, template) ->
  'use strict'

  class KeywordEntryView extends View
    template: template
    tagName: 'li'
    className: 'keyword-entry'
    autoRender: true
