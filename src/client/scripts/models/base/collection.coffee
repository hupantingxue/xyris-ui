define [
  'chaplin'
], (Chaplin) ->
  'use strict'

  class Collection extends Chaplin.Collection
    fetch: (options) ->
      options = if options then _.clone options else {}
      succ = options.success
      options.success = (collection, resp, xhr) =>
        @trigger 'change'
        if succ
          succ(collection, resp,  xhr)

      super(options)

