define [
  'jquery'
  'views/base/view'
  'plugins/jquery.autosize'
], ($, View) ->
  'use strict'

  class SearchContextQueryView extends View
    autoRender: no
    containerMethod: 'html'
    tagName: 'textarea'
    className: 'search-query'
    id: 'search-query'

    attributes: ->
      spellcheck: 'false'
      autocomplete: 'off'
      maxlength: 150
      autofocus: 'autofocus'
      placeholder: 'Type to discover...'

    initialize: ->
      super

    highlightTextBox: ->
      @$el.effect('highlight', {easing: 'easeOutCubic'})

    afterRender: ->
      super
      @$el.css({height: '55px'})
      @$el.autosize(className: 'search-query', append: '\n')
      @highlightTextBox()
      ## Come up with a better way of handling it
      @delegate 'keydown', @takeActions
      @delegate 'keyup', @queryEntered
 
    takeActions: (event) ->
      keyCode = $.ui.keyCode
      switch event.keyCode
        when keyCode.ENTER, keyCode.NUMPAD_ENTER
          event.preventDefault()
        when keyCode.TAB
          event.preventDefault()
        when keyCode.ESCAPE
          @$el.val('')
          event.preventDefault()
        when keyCode.UP, keyCode.PAGE_UP
          event.preventDefault()
        when keyCode.DOWN, keyCode.PAGE_DOWN
          event.preventDefault()
          
    queryEntered: (event) ->
      @query = @$el.val()
      keyCode = $.ui.keyCode
      switch event.keyCode
        when keyCode.ENTER, keyCode.NUMPAD_ENTER
          @publishEvent '!router:routeByName', 'search_web', {query: @query, searchContextId: @model.attributes.searchContextId, stageId: @model.attributes.stageId}, {}, (url) =>
        when keyCode.ESCAPE
          @$el.val('')
        when keyCode.TAB
          event.preventDefault() 
        else
          @publishEvent 'searchctxt:queryEntered',
            query: @query
      
   
