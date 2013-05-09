define [
  'views/search/result/base/entry-detail-view'
  'text!views/templates/search-result-entry/web-entry-detail.hbs'
], (BaseEntryDetailView,
    template) =>
  'use strict'

  class WebEntryDetailView extends BaseEntryDetailView
    template: template