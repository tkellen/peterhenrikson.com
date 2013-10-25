module.exports = (grunt) ->

  require('matchdep').filterDev('grunt-contrib*').forEach(grunt.loadNpmTasks)

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
        files: ['site/pages/**','config/**']
        tasks: ['jade:debug']

    clean:
      assets: ['public/assets']

    connect:
      options:
        hostname: '*'
        port: 8000
        base: 'public'
      debug:
        options:
          middleware: (connect, options) ->
            [
              # allow requirejs to find deps async
              connect().use('/site',connect.static(__dirname+'/site'))
              connect().use('/config',connect.static(__dirname+'/config'))
              connect().use('/components',connect.static(__dirname+'/components'))
              connect().use('/public',connect.static(__dirname+'/public'))
              # allow assets to be used without copying
              connect().use('/assets',connect.static(__dirname+'/assets'))
              connect.static(options.base)
              connect.directory(options.base)
            ]
      production:
        options:
          base: 'public'

    jade:
      debug:
        expand: true
        cwd: 'site/pages'
        src: ['*.jade','!_*.jade']
        dest: 'public'
        ext: '.html'
        options:
          data:
            config: require('./config/site'),
            debug: true
      production:
        expand: true
        cwd: 'site/pages'
        src: ['*.jade','!_*.jade']
        dest: 'public'
        ext: '.html'
        options:
          data:
            config: require('./config/site')
            debug: false

    requirejs:
      options:
        baseUrl: '',
        mainConfigFile: 'config/requirejs.js',
        name: 'components/almond/almond',
        out: 'public/site.js'

      debug:
        options:
          optimize: 'none'
      production:
        options:
          optimize: 'uglify2'

  grunt.registerTask('work', ['jade:debug', 'stylus', 'connect:debug', 'watch'])
  grunt.registerTask('production', ['clean', 'copy', 'jade:production', 'requirejs:production', 'stylus', 'connect:production:keepalive'])
  grunt.registerTask('default', ['work'])

