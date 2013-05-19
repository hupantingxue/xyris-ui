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

app = express()

app.settings.env = 'development'

app.configure ->
  app.set 'port', process.env.PORT || 8888
  app.set 'views', './build/server/views'
  app.set 'view engine', 'jade'
  app.set 'showStackError', true

  app.use express.compress()
  app.use express.favicon()
  app.use express.static('./build/client')

  app.use express.cookieParser()

  app.use express.bodyParser()
  app.use express.methodOverride()

  app.use express.session(
    secret: 'searchcontext'
    store: new RedisStore(
      host: config.redis_host
      port: config.redis_port
    )
  )
  app.use flash()

  app.use passport.initialize()
  app.use passport.session()

  app.use app.router


app.configure 'development', ->
  app.locals.title = 'Xyris UI'
  app.use express.logger 'dev'
  app.use express.errorHandler()

app.configure 'production', ->
  app.use epxress.logger stream:logFile, 'dev'

require('./routes')(app, passport)

server = http.createServer(app)
server.listen app.get('port'), ->
  console.log 'Started on port ' + app.get('port') + ' Env: ' + app.settings.env

