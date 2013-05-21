define [
  'jquery'
  'views/base/view'
  'text!views/templates/user/guest-session.hbs'
  'text!views/templates/user/logged-session.hbs'
], ($,
    View,
    guestTemplate,
    loggedTemplate) ->
  'use strict'

  class UserSessionView extends View
    autoRender: false
    containerMethod: 'html'
    container: $('#user-detail')
    autoAttach: true

    emailValidRe: /[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/

    initialize: () ->
      super
      console.log(@)
      @listenTo @model, 'change', =>
        console.log('khjk')
        if @model.get('id') isnt '0'
          @template = loggedTemplate
          @render()
        else
          @template = guestTemplate
          @render()

    attach: ->
      super
      @delegate 'click', '.login.control', (e) =>
        e.preventDefault()
        e.stopPropagation()
        @$('#login').show()

      @delegate 'click', '.signup.control', (e) =>
        e.preventDefault()
        e.stopPropagation()
        @$('#signup').show()

      @delegate 'click', '.login.close', (e) =>
        e.preventDefault()
        e.stopPropagation()
        @$('#login').hide()

      @delegate 'click', '.signup.close', (e) =>
        e.preventDefault()
        e.stopPropagation()
        @$('#signup').hide()

      @delegate 'click', '.login.action', (e) =>
        email = @$('#l-email').val().trim()
        password = @$('#l-password').val()
        @publishEvent '!user:login', email, password, (status) =>
          console.log(status)
          @model.fetch()

      @delegate 'click', '.signup.action', (e) =>
        firstName = @$('#s-first-name').val().trim()
        lastName = @$('#s-last-name').val().trim()
        email = @$('#s-email').val().trim()
        password = @$('#s-password').val()
        confirm = @$('#s-confirm').val()
        @$('#s-email').removeClass('error')
        @$('#s-password').removeClass('error')
        @$('#s-confirm').removeClass('error')
        @$('.error-msg').hide()

        if not @emailValidRe.test(email)
          @$('.signup.email.error-msg').show()
          @$('#s-email').addClass('error')
        else if confirm isnt password
          @$('.signup.pwd.error-msg').show()
          @$('#s-password').addClass('error')
          @$('#s-confirm').addClass('error')
        else
          user =
            firstName: firstName
            lastName: lastName
            email: email
            password: password
          @publishEvent '!user:create', user, (resp) =>
