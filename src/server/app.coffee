express = require 'express'
http = require 'http'
RedisStore = require('connect-redis')(express)

flash = require 'connect-flash'
passport = require 'passport'
LocalStrategy = require('passport-local').Strategy

UserUtility = require './models/user-utility'
config = require './config'
userUtility = new UserUtility

logger = require './lib/logger'

passport.serializeUser((user, done) ->
  done(null, user.id)
)

passport.deserializeUser((id, done) ->
  if id isnt '0'
    userUtility.find(_id: id, (user, err) ->
      done(err, user)
    )
  else
    done(err, id: '0')
)

passport.use(new LocalStrategy(
  usernameField: 'email'
  passwordField: 'password'
  ,
  (email, password, done) ->
    userUtility.find(email: email, (user, err) ->
      if(err)
        done(err)
      else if not user
        done(null, false, message: 'Unknown user')
      else user.authenticate(password, (auth) ->
        if auth
          return done(null, user, message: 'successfully logged')
        else
          done(null, false, message: 'Invalid password')
      )
    )
))

express()
.use(express.vhost(
  'explore.xyris.com',
  require('./apps/explore/app')(
    passport,
    stage: 'development'
    port: 80
  )
))
.use(express.vhost(
  'xyris.com',
  require('./apps/home/app')(
    passport,
    stage: 'development'
    port: 80
  )
))
.use(express.vhost(
  'home.xyris.com',
  require('./apps/home/app')(
    passport,
    stage: 'development'
    port: 80
  )
)).listen(80)