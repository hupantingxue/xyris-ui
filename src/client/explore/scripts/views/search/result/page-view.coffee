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

    statesDef:
      'search-result-view': 'searchResultViewAction'
      'search-result-detail-view': 'searchResultDetailViewAction'
      'search-trail-view': 'searchTrailViewAction'

    searchTrailViewAction: (oldState) =>
      region = (name) => @$(@invertedRegions[name])
      region('searchResultOptions').hide()
      region('searchOptions').show()
      region('searchResultContainer').addClass('seven').removeClass('four').removeClass('sidelined')
      region('searchResultDetail').hide()
      region('contextKeywords').hide()
      region('searchTrail').show()

    searchResultViewAction: (oldState) =>
      region = (name) => @$(@invertedRegions[name])
      region('searchResultOptions').hide()
      region('searchOptions').show()
      region('searchResultContainer').addClass('seven').removeClass('four').removeClass('sidelined')
      region('searchResultDetail').hide()
      region('contextKeywords').hide()
      region('searchTrail').hide()

    searchResultDetailViewAction: (oldState) =>
      region = (name) => @$(@invertedRegions[name])
      region('searchOptions').hide()
      region('searchResultOptions').show()
      region('searchResultContainer').removeClass('seven').addClass('four sidelined')
      region('searchResultDetail').show()
      region('contextKeywords').hide()
      region('searchTrail').hide()

    # Regions identified by SearchResultController and used
    # to assign different views to it
    # all region selectors are relative this this container
    regions:
      '#searchOptions': 'searchOptions'
      '#searchResultOptions': 'searchResultOptions'
      '#search-result-container': 'searchResultContainer'
      '#searchContextSummary': 'searchContextSummary'
      '#search-results': 'searchResults'
      '#context-keywords': 'contextKeywords'
      '#searchResultDetail': 'searchResultDetail'
      '#search-trail': 'searchTrail'

    initialize: ->
      super
      @invertedRegions = _.invert(@regions)
      @currentState = 'search-result-view'
      @subscribeEvent 'searchResultPage:changeState', (attributes, callback) =>
        @[@statesDef[attributes.state]](@currentState)
        @currentState = attributes.state
        callback(true)