define [
  'jquery'
  'config'
  'chaplin'
  'models/base/model'
  'controllers/base/controller'
  'views/user/user-session-view'
], ($,
    config,
    Chaplin,
    User,
    Controller,
    UserSessionView) ->
  'use strict'

  class SessionController extends Controller
    initialize: () ->
      super
      @baseUrl = config.api.baseUrl

      @user = new User
      @user.url = @baseUrl + '/user/me'
      console.log(@user)

      @view = new UserSessionView
        model: @user
        container: $('#user-detail')

      @user.fetch()
      Chaplin.mediator.user = @user

      @subscribeEvent '!user:logout', @logout
      @subscribeEvent '!user:login', @login
      @subscribeEvent '!user:create', @create

    create: (user, callback) ->
      $.post @baseUrl + '/user/create',
        firstName: user.firstName
        lastName: user.lastName
        email: user.email
        password: user.password
        (data) ->
          callback(data)

    login: (email, password, callback) ->
      $.post @baseUrl + '/user/session',
        email: email
        password: password
        (data) ->
          callback(data)

    logout: () ->
      $.post @baseUrl + '/user/logout', (data) ->