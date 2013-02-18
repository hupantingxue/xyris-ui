define [
  'views/base/view'
  'text!views/templates/search-result-entry.hbs'
], (View, template) ->
  'use strict'

  class BookResultEntryView extends View
    template: template
    tagName: 'li'
    className: 'search-result-entry'
    autoRender: true  

