module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    watch:
      scripts:
        files: '**/*.coffee'
        tasks: ['coffeelint', 'coffee', 'testacular']
    coffee:
      compile:
        files:
          'dist/angular-piwik.js': ['lib/angular-piwik.coffee']
          'test/ang-piwik-tests.js': ['test/servicesSpec.coffee']
    coffeelint:
      app: ['lib/*.coffee']
      tests: 
        files:
          src: ['test/*.coffee']
      options:
        no_trailing_whitespaces:
          level: 'error'
    testacular:
      unit:
        options:
          configFile: 'testacular.conf.js'
          browsers: if process.env.TRAVIS then ['Firefox', 'PhantomJS'] else ['PhantomJS']
          autoWatch: yes
          keepalive: yes
          singleRun: yes
    testacularRun:
      unit:
        options:
          runnerPort: 9100

  grunt.loadNpmTasks 'grunt-testacular'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-coffeelint'

  grunt.registerTask('default', ['coffeelint', 'coffee', 'testacular'])