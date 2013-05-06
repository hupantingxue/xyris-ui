module.exports = (grunt) ->
  grunt.initConfig(
    pkg: grunt.file.readJSON('package.json')
    clean:
      pre: ['build/', 'dist/']
      post: []
      afterRjs: ['build/client/']
    coffee:
      options:
        bare: false
      compile:
        files: [
          expand: true
          cwd: 'src/'
          src: ['**/*.coffee']
          dest: 'build/'
          ext: '.js'
        ]
    compass:
      compile:
        options:
          sassDir: 'src/client/styles'
          cssDir: 'build/client/styles'
          fontsDir: 'src/cleint/styles/font'
          specify: ['src/client/styles/**/*.scss', 'src/client/styles/**/*.sass']
      options:
        outputStyle: 'compressed'
    copy:
      afterRjs:
        files: [
          {
            expand: true
            cwd: 'dist/client'
            src: ['**/*']
            dest: 'build/client'
          }
        ]
      client_statics:
        files: [
          {
            expand: true
            cwd: 'src/client'
            src: ['favicon.ico', 'robots.txt', '404.html']
            dest: 'build/client'
          }
        ]
      libs:
        files: [
          {
            expand: true
            cwd: 'src/'
            src: ['client/scripts/plugins/**/*.js', 'client/scripts/vendor/**/*.js']
            dest: 'build/'
          }
        ]
      view_templates:
        files: [
          {
            expand: true
            cwd: 'src/'
            src: ['client/scripts/views/templates/**/*.hbs']
            dest: 'build/'
          }
        ]
      server_views:
        files: [
          {
            expand: true
            cwd: 'src/'
            src: ['server/views/**/*.jade']
            dest: 'build/'
          }
        ]
      fonts:
        files: [
          {
            expand: true
            cwd: 'src/'
            src: ['client/styles/font/**/*']
            dest: 'build/'
          }
        ]
    bower_install:
      install:
        options:
          targetDir: 'build/client/scripts/vendor'
          cleanup: true
    bower_require:
      all:
        rjsConfig: 'build/client/scripts/initialize.js'
    server:
      script: 'server.js'
    watch:
      server:
        files: ['src/client/**/*']
        tasks: ['server']
    imagemin:
      dist:
        options:
          optimizationLevel: 7
        files: [
          {
            expand: true
            cwd: 'src/'
            src: ['client/styles/assets/*.png']
            dest: 'build/'
          }
        ]
    open:
      dev:
        path: 'http://localhost:8888/'
    requirejs:
      dist:
        options:
          baseUrl: 'scripts'
          appDir: 'build/client/'
          mainConfigFile: 'build/client/scripts/initialize.js'
          dir: 'dist/client'
          optimize: 'none'
          modules: [
            {
              name: 'initialize'
              include: [
                'xyris-application'
              ]
            },
            {
              name: 'controllers/search-result-controller'
              exclude:[
                'xyris-application'
              ]
            },
            {
              name: 'controllers/dummy-controller'
              exclude:[
                'xyris-application'
              ]
            },
            {
              name: 'controllers/web-search-controller'
              exclude: [
                'xyris-application',
                'controllers/search-result-controller'
              ]
            },
            {
              name: 'controllers/rsrchart-search-controller'
              exclude: [
                'xyris-application',
                'controllers/search-result-controller'
              ]
            },
            {
              name: 'controllers/docs-search-controller'
              exclude: [
                'xyris-application',
                'controllers/search-result-controller'
              ]
            }
          ]
    coffeelint:
      all: 'src/**/*.coffee'
      grunt: 'Gruntfile.coffee'
      options:
        'indentation':
          'level': 'warn'
        'max_line_length':
          'level': 'warn'
  )

  require('matchdep').filterDev('grunt-*').forEach((dep) ->
    grunt.loadNpmTasks(dep)
    if dep == 'grunt-bower-hooks'
      grunt.renameTask('bower', 'bower_require')
    else if dep == 'grunt-bower-task'
      grunt.renameTask('bower', 'bower_install')
  )

  stage = grunt.option('target') || 'dev'

  grunt.registerTask('default', ['coffeelint'
                                 'clean:pre',
                                 'coffee',
                                 'compass',
                                 'copy',
                                 'bower_install',
                                 'bower_require',
                                 'copy:libs',
                                 'imagemin',
                                 'requirejs',
                                 'clean:afterRjs',
                                 'copy:afterRjs',
                                 'clean:post'])

  grunt.registerTask('server', ['default', 'express-server', 'open:dev', 'watch'])

  grunt.registerTask('tempstart', ['express-server', 'open:dev', 'watch'])

