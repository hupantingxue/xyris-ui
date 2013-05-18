define [
  'views/base/view'
  'text!views/templates/user/guest-session.hbs'
  'text!views/templates/user/logged-session.hbs'
], (View,
    guestTemplate,
    loggedTemplate) ->
  'use strict'

  class UserSessionView extends View
    initialize: () ->
      super
      console.log(@)
      @listenTo @model, 'change', =>
        if @model.get('id') isnt '0'
          @template = loggedTemplate
          @render()
        else
          @template = guestTemplate
          @render()

    attach: () ->
      super