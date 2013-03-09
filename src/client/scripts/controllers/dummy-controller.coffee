define [
  'controllers/base/controller'
], (Controller) ->
  'use strict'

  class DummyController extends Controller
    do_nothing: ->
      console.log('as')
