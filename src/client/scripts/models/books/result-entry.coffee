define [
  'models/base/model'
], (Model) ->
  'use strict'

  class BookResultEntry extends Model
    urlKey: 'id'
    urlPath: ->
      "/book/"

