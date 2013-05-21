express = require 'express'
RedisStore = require('connect-redis')(express)

flash = require 'connect-flash'

module.exports =
(passport, config) ->
  app = express()

  app.settings.env = config.stage

  app.configure ->
    app.set 'port', config.port
    app.set 'views', './build/server/views'
    app.set 'view engine', 'jade'
    app.set 'showStackError', true

    app.use express.compress()
    app.use express.favicon()
    app.use express.static('./build/client/explore', maxAge: 31557600000)

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

  return app