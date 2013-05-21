define [
  'views/search/result/base/entry-view'
  'text!views/templates/search-result-entry/rsrchart-result-entry.hbs'
], (BaseEntryView, template) ->
  'use strict'

  class RsrchartResultEntryView extends BaseEntryView
    template: template