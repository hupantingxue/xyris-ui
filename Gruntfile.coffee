module.exports = (grunt) ->
  grunt.initConfig(
    pkg: grunt.file.readJSON('package.json')
    clean:
      pre: ['build/']
      post: []
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
    sass:
      compile:
        files: [
          expand: true
          cwd: 'src/'
          src: ['**/*.sass']
          dest: 'build/'
          ext: '.css'
        ]
    copy:
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
        files: ['**/*.js']
        tasks: ['express-server', 'livereload']
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
  )

  require('matchdep').filterDev('grunt-*').forEach((dep) ->
    grunt.loadNpmTasks(dep)
    if dep == 'grunt-bower-hooks'
      grunt.renameTask('bower', 'bower_require')
    else if dep == 'grunt-bower-task'
      grunt.renameTask('bower', 'bower_install')
  )

  grunt.registerTask('default', ['clean:pre', 'coffee', 'sass', 'copy', 'bower_install', 'bower_require', 'copy:libs', 'imagemin', 'clean:post'])

  grunt.registerTask('server', ['default', 'express-server', 'livereload', 'watch'])

