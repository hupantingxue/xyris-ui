define [
  'views/search/result/base/entry-detail-view'
  'text!views/templates/search-result-entry/rsrchart-entry-detail.hbs'
], (BaseEntryDetailView,
    template) =>
  'use strict'

  class DocsEntryDetailView extends BaseEntryDetailView
    template: template