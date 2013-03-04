define [
  'jquery'
  'config'
  'views/base/view'
  'models/base/model'
  'chaplin/lib/delayer'
  'autosize'
], ($,
    config,
    View,
    Model,
    Delayer) ->

  'use strict'

  class SearchContextQueryView extends View
    autoRender: no
    containerMethod: 'prepend'
    tagName: 'textarea'
    className: 'search-query'
    id: 'search-query'

    _(@prototype).extend Delayer

    attributes: ->
      spellcheck: 'false'
      autocomplete: 'off'
      maxlength: 150
      autofocus: 'autofocus'
      placeholder: ''

    initialize: ->
      super
      @typeahead_model = new Model
      @listenTo @typeahead_model, 'change', @showTypeaheadSuggestion

    highlightTextBox: ->
      @$el.effect('highlight', {easing: 'easeOutCubic'})

    initiateTypeaheadSuggestion: () =>
      if @query != ""
        query = encodeURIComponent(@query)
        @typeahead_model.url = config.api.versionRoot + "/typeahead/suggest?query=#{query}"
        @typeahead_model.fetch()

    showTypeaheadSuggestion: (query) ->
        $('#search-typeahead').show()
        original_query = @query
        match_str = escape(original_query).replace(/%20/g, " ")
        q_regex = new RegExp("(#{match_str})", "g")
        new_query = @typeahead_model.get('suggestion')
        matches = new_query.match(q_regex)
        if matches? && matches.length != 0
          new_query = new_query.replace(q_regex, "<span>$1</span>")
          new_query = new_query.replace(/\s/g, "&nbsp;")
          $('#search-typeahead').html(new_query)

    attach: ->
      super
      @$el.css({height: '49px'})
      @$el.autosize(className: 'search-query', append: '')
      ## Come up with a better way of handling it
      @delegate 'keydown', @takeActions
      @delegate 'keyup', @queryEntered

    takeActions: (event) ->
      $('#search-typeahead').hide()
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
          @setTimeout("typeahead", 400, @initiateTypeaheadSuggestion)
          @publishEvent 'searchctxt:queryEntered',
            query: @query
