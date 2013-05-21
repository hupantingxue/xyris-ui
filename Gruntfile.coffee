module.exports = (grunt) ->
  grunt.initConfig(
    pkg: grunt.file.readJSON('package.json')
    clean:
      pre: ['build/', 'dist/']
      post: []
      afterRjs: ['build/client/explore']
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
      compile_server:
        files: [
          expand: true
          cwd: 'src/server/'
          src: ['**/*.coffee']
          dest: 'build/server/'
          ext: '.js'
        ]
    compass:
      compile_explore:
        options:
          sassDir: 'src/client/explore/styles'
          cssDir: 'build/client/explore/styles'
          fontsDir: 'src/client/explore/styles/font'
          specify: ['src/client/explore/styles/**/*.scss', 'src/client/explore/styles/**/*.sass']
      compile_home:
        options:
          sassDir: 'src/client/home/styles'
          cssDir: 'build/client/home/styles'
          fontsDir: 'src/client/home/styles/font'
          specify: ['src/client/home/styles/**/*.scss', 'src/client/home/styles/**/*.sass']
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
      libs_explore:
        files: [
          {
            expand: true
            cwd: 'src/'
            src: ['client/explore/scripts/plugins/**/*.js', 'client/explore/scripts/vendor/**/*.js']
            dest: 'build/'
          }
        ]
      libs_home:
        files: [
          {
            expand: true
            cwd: 'src/'
            src: ['client/home/scripts/**/*.js']
            dest: 'build/'
          }
        ]
      view_templates_explore:
        files: [
          {
            expand: true
            cwd: 'src/'
            src: ['client/explore/scripts/views/templates/**/*.hbs']
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
      fonts_explore:
        files: [
          {
            expand: true
            cwd: 'src/'
            src: ['client/explore/styles/font/**/*']
            dest: 'build/'
          }
        ]
      fonts_home:
        files: [
          {
            expand: true
            cwd: 'src/'
            src: ['client/home/styles/font/**/*']
            dest: 'build/'
          }
        ]
      image_home_copy:
        files: [
          {
            expand: true
            cwd: 'src/'
            src: ['client/home/styles/assets/**/*.png','client/home/styles/assets/**/*.jpg']
            dest: 'build/'
          }
        ]
      bower_copy:
        files: [
          {
            expand: true
            cwd: 'bower_temp'
            src: ['client/explore/scripts/vendor/**/*']
            dest: 'build/'
          }
        ]
    bower_install:
      install:
        options:
          targetDir: 'bower_temp/client/explore/scripts/vendor'
          cleanup: false
    bower_require:
      all:
        rjsConfig: 'build/client/explore/scripts/initialize.js'
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
            src: ['client/explore/styles/assets/*.png', 'client/home/styles/assets/*.png']
            dest: 'build/'
          }
        ]
    open:
      dev:
        path: 'http://explore.xyris.com'
    requirejs:
      dist:
        options:
          baseUrl: 'scripts'
          appDir: 'build/client/explore'
          mainConfigFile: 'build/client/explore/scripts/initialize.js'
          dir: 'dist/client/explore'
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
                                 'bower_require',
                                 'copy:libs_explore',
                                 'imagemin',
                                 'requirejs',
                                 'clean:afterRjs',
                                 'copy:afterRjs',
                                 'clean:post'])

  grunt.registerTask('server', ['default', 'express-server', 'open:dev', 'watch'])

  grunt.registerTask('tempstart', ['express-server', 'open:dev', 'watch'])

