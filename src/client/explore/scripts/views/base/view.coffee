define [
  'chaplin'
  'handlebars'
  'lib/view_helper'
], (Chaplin, Handlebar) ->
  'use strict'

  class View extends Chaplin.View
    containerMethod: 'append'
    initialize: ->
      super

    getTemplateFunction: ->
      template = @template
      if typeof template is 'string'
        templateFunc = Handlebars.compile template
        @constructor::template = templateFunc
      else
        templateFunc = template

      templateFunc
