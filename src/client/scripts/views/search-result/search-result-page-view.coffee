define [
  'views/base/view'
  'text!views/templates/search-result-page.hbs'
], (View,
    template) ->
  'use strict'

  # [RECONSIDER]
  # Name of the class might more suite to be SearchResultLayoutView
  # As Layout View only defines regions and contain no
  # subviews.
  # LayoutViews only listens on events whose purpose should
  # be restricted to actions like transition or display changes
  # of regions defined
  #
  # [Functionality to add]
  # region transformation or transitions on certain events
  # Notes:
  # when a search result is clicked then the searchResults region
  # is transitioned to rightmost seaction. and searchResultDetails
  # region is composed approprietly by their respective SearchResult
  # View.
  class SearchResultPageView extends View
    tagName: 'div'
    className: 'search-result-page'
    template: template
    containerMethod: 'html'

    # Regions identified by SearchResultController and used
    # to assign different views to it
    # all region selectors are relative this this container
    regions:
      '#searchOptions': 'searchOptions'
      '#searchResultOptions': 'searchResultOptions'
      '#searchContextSummary': 'searchContextSummary'
      '#search-results': 'searchResults'
      '#contextKeywords': 'contextKeywords'
      '#searchResultDetail': 'searchResultDetail'

    initialize: ->
      super
      @invertedRegions = _.invert(@regions)