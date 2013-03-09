define [
  'views/base/view'
  'text!views/templates/base-layout.hbs'
], (View,
    template) ->
  'use strict'

  class BaseLayoutView extends View

    autoRender: yes
    template: template
    container: 'body'

    # containerMethod is set prepend because browser's
    # plugin sometimes insert their custom elements to function
    containerMethod: 'prepend'

    listen:
      'baseLayout:displaySearchContextPage': () ->
        @$el.find(@invertedRegions.searchContext).show()
        @$el.find(@invertedRegions.main).hide()

    # Setting basic regions never to be unregistered
    regions:
      '#header': 'header'
      '#footer': 'footer'
      '#main': 'main'
      '#search-context': 'searchContext'

    initialize: ->
      super
      @invertedRegions = _.invert(@regions)
      @subscribeEvent 'matchRoute', (route, params, options) =>
        if route.name == 'search_result'
          @$el.find(@invertedRegions.searchContext).hide()
          @$el.find(@invertedRegions.main).show()
        else if route.name == 'index'
          @$el.find(@invertedRegions.searchContext).show()
          @$el.find(@invertedRegions.main).hide




