define [
  'models/base/model'
], (Model) ->
  'use strict'

  class Keyword extends Model
    urlKey: 'id'
    urlPath: -> 
      "/category/"
