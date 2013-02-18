FILE_ENCODING = 'utf-8'
EOL = '\n'
fs = require 'fs'
path = require 'path'
util = require('util')
print = require('util').print
exec = require('child_process').exec
spawn = require('child_process').spawn


# PATHS
appPath		 = __dirname

appCompPath	 = "#{appPath}/build"
jsPath		 = "#{appCompPath}/client/scripts"
cssPath		 = "#{appCompPath}/client/styles"

appSrcPath	 = "#{appPath}/src"
clientJsPath 	 = "#{appSrcPath}/client/scripts"
clientSassPath 	 = "#{appSrcPath}/client/styles"


# COMPILERS
sassExec 	 = 'sass'
coffeeExec 	 = "#{appPath}/node_modules/coffee-script/bin/coffee"


# TASKS

task 'development', ->
  invoke 'clean' 
  invoke 'watchCoffeeScript'
  invoke 'watchSass'

task 'clean', ->
  fs.rmdir('build')

task 'production', ->
  invoke 'watchCoffeeScript'
  invoke 'watchSass'

task 'concatJs', ->
  concat = (opts) ->
    console.log 'Concatenating Client JS...'
    fileList = opts.src
    distFile = opts.dest
    out = fileList.map((filePath) -> fs.readFileSync filePath, FILE_ENCODING)
    fs.writeFileSync(distFile, out.join(EOL), FILE_ENCODING)
    console.log " " + distFile + " built."


  concat
    src: [
      #Modules
      "#{jsPath}/modules/m1.js",
      "#{jsPath}/modules/m2.js"
    ]
    dest: appCompPath + '/client/scripts/application.js'

task 'watchCoffeeScript', ->
   console.log 'Starting Coffee watcher'
   Helper.spawnWatcher(coffeeExec, [ '--watch', '--compile', '--output', appCompPath, appSrcPath])

task 'watchSass', ->
  console.log 'Starting Sass watcher'
  Helper.spawnWatcher(sassExec, [ '--watch', "#{clientSassPath}:#{cssPath}", '-t', 'expanded'])

Helper = {}

Helper.spawnWatcher = (compiler, flags) ->
  watcher = spawn compiler, flags
  watcher.stdout.on 'data', (data) -> print data.toString()
  watcher.stderr.on 'data', (data) -> print data.toString()
  watcher.on 'exit', (status) -> callback?() if status is 0



