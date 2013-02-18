define [
  'views/base/collection-view'
], (CollectionView) ->
  'use strict'

  class KeywordsView extends CollectionView
    className: 'keywords list'
    tagName: 'ul'
    containerMethod: 'append'
    autoRender: false
   
    getView: (model) ->
      model.set(query: @options.query)
      super(model)
