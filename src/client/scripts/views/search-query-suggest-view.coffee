define [
  'views/base/collection-view'
], (CollectionView) ->
  'use strict'

  class SearchQuerySuggestView extends CollectionView
    className: 'search-queries-suggest'
    tagName: 'ul'

    initialize: ->
      super
      rendered = yes
      @listenTo @collection, 'change', =>
        @render() unless rendered
        rendered = no
