define [
  'controllers/base/controller'
  'views/base-layout-view'
], (Controller, BaseLayoutView) ->
  'use strict'

  class BaseLayoutController extends Controller

    initialize: ->
      super
      @show()

    show:  ->
      @base_layout_view = new BaseLayoutView

