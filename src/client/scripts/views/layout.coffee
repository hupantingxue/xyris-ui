define [
  'chaplin'
], (Chaplin) ->
  'use strict'

  class Layout extends Chaplin.Layout
    initialize: ->
      super
      @initialVisit = yes
      @subscribeEvent 'startupController', @trackVisit

    trackVisit: =>
      if @initialVisit
        window._gauges?.track_referer = yes
        @initialVisit = no
      window._gauges?.push['track'] 
