define [
  'controllers/base/controller'
], (Controller) ->
  'use strict'

  class PublishEventController extends Controller

    show_search: ->
      @publishEvent 'searchctxt:show_search', {}
