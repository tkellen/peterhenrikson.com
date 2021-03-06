module.exports = (grunt) ->

  require('matchdep').filterDev('grunt-contrib*').forEach grunt.loadNpmTasks

  grunt.initConfig
    meta:
      assets:
        src: 'assets/'
        dest: 'public/assets'

    concat:
      coffee:
        src: ['<%= meta.assets.src %>/js/*.coffee']
        dest: 'tmp/site.coffee'

      js:
        src: ['<%= meta.assets.src %>/js/lib/jquery.js',
              '<%= meta.assets.src %>/js/lib/*.js',
              'tmp/site.js']
        dest: '<%= meta.assets.dest %>/site.js'

    coffee:
      compile:
        src: ['tmp/site.coffee']
        dest: 'tmp/site.js'
        options:
          bare: true

    uglify:
      site:
        src: '<%= meta.assets.dest %>/site.js'
        dest: '<%= meta.assets.dest %>/site.js'

    stylus:
      options:
        urlfunc: 'embedurl'
        paths: ['<%= meta.assets.src %>/css',
                '<%= meta.assets.src %>/img']
        'include css': true

      develop:
        src: '<%= meta.assets.src %>/css/site.styl'
        dest: '<%= meta.assets.dest %>/site.css'

    cssmin:
      site:
        src: '<%= meta.assets.dest %>/site.css'
        dest: '<%= meta.assets.dest %>/site.css'

    copy:
      images:
        expand: true
        src: 'assets/img/**/*'
        dest: 'public/'

      fonts:
        expand: true
        src: 'assets/fonts/**/*'
        dest: 'public/'

      www:
        expand: true
        cwd: 'assets/www/'
        src: '**/*'
        dest: 'public/'

    connect:
      server:
        options:
          port: 8000
          base: 'public'

    watch:
      css:
        files: ['<%= meta.assets.src %>/css/**/*']
        tasks: ['stylus']

      js:
        files: ['<%= meta.assets.src %>/js/**/*']
        tasks: ['js']

      pages:
        files: ['pages/*.jade']
        tasks: ['compile']

    clean:
      tmp: ['tmp']
      site: ['public']
      assets: ['public/assets']

    htmlmin:
      site:
        options:
          removeComments: true
          collapseWhitespace: true

        expand: true
        cwd: 'public/'
        src: '**/*.html'
        dest: 'public/'

    # total hack
    grunt.registerTask "staticsite", ->

      # pull context out of file
      context = (str) ->
        ctx = {}
        try
          yaml = str.match(/\/\/-\n([\s\S]*)(?=\/\/-)/)[1]
          ctx = YAML.load(yaml)
        ctx
      path = require("path")
      YAML = require("js-yaml")
      grunt.log.writeln "Building list of pages to generate."
      grunt.file.expand("pages/*.jade").forEach (file, i) ->
        grunt.config.set "jade.page" + i,
          options:
            data: context(grunt.file.read(file))
            pretty: true

          src: file
          dest: "public/" + path.basename(file, ".jade").replace(/_/g, "/") + ".html"


  # concat site libs and coffeescript
  grunt.registerTask 'js', ['concat:coffee', 'coffee', 'concat:js', 'clean:tmp']

  # compile static html
  grunt.registerTask 'compile', ['staticsite', 'jade']

  # copy assets
  grunt.registerTask 'assets', ['clean:assets', 'copy']

  # start working environment
  grunt.registerTask 'work', ['develop', 'connect', 'watch']

  # prep site for development
  grunt.registerTask 'develop', ['clean:site', 'assets', 'js', 'stylus', 'compile']

  # prep site for production (minify js/css)
  grunt.registerTask 'production', ['develop', 'uglify', 'cssmin']

  # start working
  grunt.registerTask 'default', ['work']