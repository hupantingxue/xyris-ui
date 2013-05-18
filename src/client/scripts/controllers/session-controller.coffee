define [
  'jquery'
  'config'
  'chaplin'
  'models/base/model'
  'controllers/base/controller'
  'views/user-session-view'
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
      @compose 'user-detail', UserSessionView,
        region: 'userDetail'
        model: @user
        autoRender: false

      @user.fetch()
      Chaplin.mediator.user = @user

      @subscribeEvent '!user:logout', @logout
      @subscribeEvent '!user:login', @login
      @subscribeEvent '!user:create', @create

    create: (user, callback) ->
      $.post @baseUrl + '/user/create',
        name: user.name
        email: user.email
        password: user.password
        (data) ->
          callback(data)

    login: (email, password) ->
      $.post @baseUrl + '/user/session',
        email: email
        password: password
        (data) ->
          console.log(data)

    logout: () ->
      $.post @baseUrl + '/user/logout', (data) ->