module.exports = (grunt) ->

  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  grunt.initConfig

    stylus:
      options:
        'include css': true
      css:
        src: 'site/styles/style.styl'
        dest: 'public/style.css'

    copy:
      assets:
        expand: true
        cwd: 'site'
        src: 'assets/**/*'
        dest: 'public'

    watch:
      options:
        livereload: true

      assets:
        files: ['site/assets/**/*']
        tasks: ['copy']
      site:
        files: ['site/*']
      css:
        files: ['site/styles/*']
        tasks: ['stylus']
      jade:
        files: ['site/views/**','config/**']
        tasks: ['jade:development']

    clean:
      assets: ['public/assets']

    express:
      options:
        script: 'app.js'
      production:
        options:
          node_env: 'production'
      development:
        options:
          node_env: 'development'

    jade:
      development:
        expand: true
        cwd: 'site/views'
        src: ['*.jade','!_*.jade']
        dest: 'public'
        ext: '.html'
        options:
          filters:
            moment: require('moment')
          data:
            config: require('./config/site'),
            debug: true
      production:
        expand: true
        cwd: 'site/views'
        src: ['*.jade','!_*.jade']
        dest: 'public'
        ext: '.html'
        options:
          filters:
            moment: require('moment')
          data:
            config: require('./config/site')
            debug: false

    requirejs:
      options:
        baseUrl: '',
        mainConfigFile: 'config/requirejs.js',
        name: 'components/almond/almond',
        out: 'public/site.js'

      development:
        options:
          optimize: 'none'
      production:
        options:
          optimize: 'uglify2'

  grunt.registerTask('work', ['jade:development', 'stylus', 'express:development', 'watch'])
  grunt.registerTask('production', ['clean', 'copy', 'jade:production', 'requirejs:production', 'stylus'])
  grunt.registerTask('default', ['work'])

