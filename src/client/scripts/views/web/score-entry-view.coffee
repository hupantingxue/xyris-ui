define [
  'views/base/view'
  'text!views/templates/score-result-entry.hbs'
], (View, template) ->
  'use strict'
  class BookScoreEntryView extends View
    template: template
    tagName: 'li'
    className: 'book-score-entry'
    autoRender: true
