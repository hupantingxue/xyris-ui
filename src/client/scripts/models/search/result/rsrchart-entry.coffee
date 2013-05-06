define [
  'underscore'
  'models/base/model'
], (_, Model) ->
  'use strict'

  class WebResultEntry extends Model
    urlKey: 'id'
    urlPath: ->
      "/book/"

