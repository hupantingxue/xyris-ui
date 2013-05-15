express = require 'express'
app = express()
fs = require 'fs'
cake = './node_modules/coffee-script/bin/cake'
exec = require('child_process').exec
http = require 'http'

app.settings.env = 'development'

app.configure ->
  app.set 'port', process.env.PORT || 8888
  app.set 'views', './build/server/views'
  app.set 'view engine', 'jade'

  app.use express.compress()
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static('./build/client')

app.configure 'development', ->
  app.locals.title = 'Xyris UI'
  app.use express.logger 'dev'
  app.use express.errorHandler()

app.configure 'production', ->
  exec cake + ' ' + app.settings.env
  logFile = fs.createWriteStream('./xyris-ui.log', flags: 'w')
  app.use epxress.logger stream:logFile, 'dev'

require('./routes')(app)

server = http.createServer(app)
server.listen app.get('port'), ->
  console.log 'Started on port ' + app.get('port') + ' Env: ' + app.settings.env

