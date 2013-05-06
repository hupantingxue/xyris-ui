define [
  'views/search/result/base/entry-view'
  'text!views/templates/search-result-entry/docs-result-entry.hbs'
], (BaseEntryView, template) ->
  'use strict'

  class DocsResultEntryView extends BaseEntryView
    template: template