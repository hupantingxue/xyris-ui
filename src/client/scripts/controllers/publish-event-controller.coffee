define [
  'controllers/base/controller'
], (Controller) ->
  'use strict'

  class PublishEventController extends Controller

    show_search_context_page: ->
      @publishEvent 'searchctxt:show_search_context_page', {}
