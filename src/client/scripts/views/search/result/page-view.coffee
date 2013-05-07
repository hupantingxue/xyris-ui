define [
  'jquery'
  'views/base/view'
  'text!views/templates/search-result-page.hbs'
], ($,
    View,
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

    # defined states of SearchResultPage are
    # - search-result-view
    # - search-result-detail-view
    # - search-context-edit-view
    # - search-trail-view
    # - information-prospect-view
    #
    # These states are used to identify and manage what different section
    # are visible and corresponding transition from one state to another

    statesDef: {
      'search-result-view': {
        'action': (oldState) =>
          console.log('changed to search-result-view state')
      },
      'search-result-detail-view': {
        'action': (oldState) =>
          @$(@invertedRegions['searchResultDetail']).show()
          @$(@invertedRegions['searchResults']).removeClass('twelve').addClass('three')
      }
    }
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
      @currentState = 'search-result-view'
      @subscribeEvent 'searchResultPage:changeState', (attributes, callback) =>
        @statesDef[attributes.state]['action'](@currentState)
        @currentState = attributes.state