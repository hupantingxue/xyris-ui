define [
  'views/base/collection-view'
], (CollectionView) ->
  'use strict'

  class KeywordsView extends CollectionView
    className: 'ctxt-keywords list'
    tagName: 'ul'
    containerMethod: 'append'
    autoRender: false
