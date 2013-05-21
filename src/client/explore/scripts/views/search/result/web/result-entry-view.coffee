define [
  'views/search/result/base/entry-view'
  'text!views/templates/search-result-entry/web-result-entry.hbs'
], (BaseEntryView, template) ->
  'use strict'

  class WebResultEntryView extends BaseEntryView
    template: template