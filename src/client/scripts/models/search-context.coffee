define [
  'models/base/model'
], (Model) ->
  'use strict'

  class SearchContext extends Model 
    urlKey: 'id'
    urlPath: ->
      '/searchctxt/'
