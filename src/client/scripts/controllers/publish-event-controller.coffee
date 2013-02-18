define [
  'controllers/base/controller'
], (Controller) ->
  'use strict'

  class PublishEventController extends Controller
    show_search_context: ->
      @publishEvent 'searchctxt:show', {}
  
