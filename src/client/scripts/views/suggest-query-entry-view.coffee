define [
  'views/base/view'
], (View, template) ->
  'use strict'

  class SuggestQueryEntryView extends View
    template: (context) ->
      return context.suggestedQuery

    tagName: 'li'
    className: 'suggest-query-entry'
    autoRender: true
