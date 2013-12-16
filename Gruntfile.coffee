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
        files: ['site/index.coffee']
      views:
        files: ['site/views/**/*']
        tasks: ['express:development']
      css:
        files: ['site/styles/*']
        tasks: ['stylus']

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

  grunt.registerTask('work', ['stylus', 'express:development', 'watch'])
  grunt.registerTask('production', ['clean', 'copy', 'requirejs:production', 'stylus'])
  grunt.registerTask('default', ['work'])

